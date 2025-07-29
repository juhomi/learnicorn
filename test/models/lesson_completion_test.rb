require "test_helper"

class LessonCompletionTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    lesson_completion = LessonCompletion.new(
      user: users(:student),
      lesson: lessons(:ruby_intro)
    )
    assert lesson_completion.valid?
  end

  test "should require user" do
    lesson_completion = LessonCompletion.new(lesson: lessons(:ruby_intro))
    assert_not lesson_completion.valid?
    assert_includes lesson_completion.errors[:user], "must exist"
  end

  test "should require lesson" do
    lesson_completion = LessonCompletion.new(user: users(:student))
    assert_not lesson_completion.valid?
    assert_includes lesson_completion.errors[:lesson], "must exist"
  end

  test "should require unique user per lesson" do
    # Create first lesson completion
    LessonCompletion.create!(user: users(:student), lesson: lessons(:ruby_intro))

    # Try to create duplicate lesson completion
    duplicate_completion = LessonCompletion.new(user: users(:student), lesson: lessons(:ruby_intro))
    assert_not duplicate_completion.valid?
    assert_includes duplicate_completion.errors[:user_id], "has already completed this lesson"
  end

  test "should allow same user to complete different lessons" do
    # Create second lesson
    lesson2 = Lesson.create!(
      title: "Ruby Variables",
      content: "Learn about Ruby variables and data types",
      position: 2,
      course: courses(:ruby_course)
    )

    # Create first lesson completion
    completion1 = LessonCompletion.create!(user: users(:student), lesson: lessons(:ruby_intro))

    # Create second lesson completion with same user, different lesson
    completion2 = LessonCompletion.new(user: users(:student), lesson: lesson2)
    assert completion2.valid?
  end

  test "should allow different users to complete same lesson" do
    # Create second student
    student2 = User.create!(
      name: "Jane Doe",
      email: "jane@example.com",
      role: "student",
      password: "password123"
    )

    # Create first lesson completion
    completion1 = LessonCompletion.create!(user: users(:student), lesson: lessons(:ruby_intro))

    # Create second lesson completion with different user, same lesson
    completion2 = LessonCompletion.new(user: student2, lesson: lessons(:ruby_intro))
    assert completion2.valid?
  end

  test "should belong to user" do
    lesson_completion = LessonCompletion.create!(user: users(:student), lesson: lessons(:ruby_intro))
    assert_respond_to lesson_completion, :user
    assert_kind_of User, lesson_completion.user
  end

  test "should belong to lesson" do
    lesson_completion = LessonCompletion.create!(user: users(:student), lesson: lessons(:ruby_intro))
    assert_respond_to lesson_completion, :lesson
    assert_kind_of Lesson, lesson_completion.lesson
  end

  test "should set completed_at before create" do
    lesson_completion = LessonCompletion.new(
      user: users(:student),
      lesson: lessons(:ruby_intro)
    )

    assert_nil lesson_completion.completed_at
    lesson_completion.save!
    assert_not_nil lesson_completion.completed_at
    assert_kind_of Time, lesson_completion.completed_at
  end

  test "should not override completed_at if already set" do
    specific_time = 1.day.ago
    lesson_completion = LessonCompletion.new(
      user: users(:student),
      lesson: lessons(:ruby_intro),
      completed_at: specific_time
    )

    lesson_completion.save!
    assert_equal specific_time.to_i, lesson_completion.completed_at.to_i
  end

  test "recent scope should return lesson completions ordered by completed_at desc" do
    # Create lesson completions with different times
    completion1 = LessonCompletion.create!(
      user: users(:student),
      lesson: lessons(:ruby_intro),
      completed_at: 3.days.ago
    )

    # Create second lesson
    lesson2 = Lesson.create!(
      title: "Ruby Variables",
      content: "Learn about Ruby variables and data types",
      position: 2,
      course: courses(:ruby_course)
    )

    completion2 = LessonCompletion.create!(
      user: users(:student),
      lesson: lesson2,
      completed_at: 1.day.ago
    )

    # Create third lesson
    lesson3 = Lesson.create!(
      title: "Ruby Methods",
      content: "Learn about Ruby methods and functions",
      position: 3,
      course: courses(:ruby_course)
    )

    completion3 = LessonCompletion.create!(
      user: users(:student),
      lesson: lesson3,
      completed_at: 2.days.ago
    )

    recent_completions = LessonCompletion.recent
    assert_equal [ completion2, completion3, completion1 ], recent_completions.to_a
  end

  test "should use current time for completed_at if not provided" do
    freeze_time = Time.current

    travel_to freeze_time do
      lesson_completion = LessonCompletion.create!(
        user: users(:student),
        lesson: lessons(:ruby_intro)
      )

      assert_equal freeze_time.to_i, lesson_completion.completed_at.to_i
    end
  end

  test "set_completed_at should only set if completed_at is nil" do
    lesson_completion = LessonCompletion.new(
      user: users(:student),
      lesson: lessons(:ruby_intro)
    )

    # Mock the callback being called
    lesson_completion.send(:set_completed_at)
    first_time = lesson_completion.completed_at

    # Call again - should not change
    lesson_completion.send(:set_completed_at)
    assert_equal first_time, lesson_completion.completed_at
  end

  test "should track lesson completion across course progress" do
    course = courses(:ruby_course)
    student = users(:student)

    # Create multiple lessons
    lesson1 = course.lessons.create!(title: "Lesson 1", content: "This is lesson content 1", position: 1)
    lesson2 = course.lessons.create!(title: "Lesson 2", content: "This is lesson content 2", position: 2)
    lesson3 = course.lessons.create!(title: "Lesson 3", content: "This is lesson content 3", position: 3)

    # Complete lessons progressively
    completion1 = LessonCompletion.create!(user: student, lesson: lesson1, completed_at: 3.days.ago)
    completion2 = LessonCompletion.create!(user: student, lesson: lesson2, completed_at: 2.days.ago)
    completion3 = LessonCompletion.create!(user: student, lesson: lesson3, completed_at: 1.day.ago)

    # Verify completions are tracked
    assert_equal 3, student.lesson_completions.count
    assert_includes student.lesson_completions, completion1
    assert_includes student.lesson_completions, completion2
    assert_includes student.lesson_completions, completion3
  end
end
