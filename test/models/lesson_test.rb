require "test_helper"

class LessonTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    lesson = Lesson.new(
      title: "Introduction to Ruby",
      content: "Learn the basics of Ruby programming language",
      position: 1,
      course: courses(:ruby_course)
    )
    assert lesson.valid?
  end

  test "should require title" do
    lesson = Lesson.new(
      content: "Learn the basics of Ruby programming language",
      position: 1,
      course: courses(:ruby_course)
    )
    assert_not lesson.valid?
    assert_includes lesson.errors[:title], "can't be blank"
  end

  test "should require title to be at least 3 characters" do
    lesson = Lesson.new(
      title: "Ru",
      content: "Learn the basics of Ruby programming language",
      position: 1,
      course: courses(:ruby_course)
    )
    assert_not lesson.valid?
    assert_includes lesson.errors[:title], "is too short (minimum is 3 characters)"
  end

  test "should require title to be at most 100 characters" do
    lesson = Lesson.new(
      title: "a" * 101,
      content: "Learn the basics of Ruby programming language",
      position: 1,
      course: courses(:ruby_course)
    )
    assert_not lesson.valid?
    assert_includes lesson.errors[:title], "is too long (maximum is 100 characters)"
  end

  test "should not require content" do
    lesson = Lesson.new(
      title: "Introduction to Ruby",
      position: 1,
      course: courses(:ruby_course)
    )
    assert lesson.valid?
  end

  test "should allow short content" do
    lesson = Lesson.new(
      title: "Introduction to Ruby",
      content: "Short",
      position: 1,
      course: courses(:ruby_course)
    )
    assert lesson.valid?
  end

  test "should require content to be at most 5000 characters" do
    lesson = Lesson.new(
      title: "Introduction to Ruby",
      content: "a" * 5001,
      position: 1,
      course: courses(:ruby_course)
    )
    assert_not lesson.valid?
    assert_includes lesson.errors[:content], "is too long (maximum is 5000 characters)"
  end

  test "should require position" do
    lesson = Lesson.new(
      title: "Introduction to Ruby",
      content: "Learn the basics of Ruby programming language",
      course: courses(:ruby_course)
    )
    assert_not lesson.valid?
    assert_includes lesson.errors[:position], "can't be blank"
  end

  test "should require position to be greater than 0" do
    lesson = Lesson.new(
      title: "Introduction to Ruby",
      content: "Learn the basics of Ruby programming language",
      position: 0,
      course: courses(:ruby_course)
    )
    assert_not lesson.valid?
    assert_includes lesson.errors[:position], "must be greater than 0"
  end

  test "should require course" do
    lesson = Lesson.new(
      title: "Introduction to Ruby",
      content: "Learn the basics of Ruby programming language",
      position: 1
    )
    assert_not lesson.valid?
    assert_includes lesson.errors[:course], "must exist"
  end

  test "should accept valid video URL" do
    lesson = Lesson.new(
      title: "Introduction to Ruby",
      content: "Learn the basics of Ruby programming language",
      position: 1,
      course: courses(:ruby_course),
      video_url: "https://example.com/video.mp4"
    )
    assert lesson.valid?
  end

  test "should accept blank video URL" do
    lesson = Lesson.new(
      title: "Introduction to Ruby",
      content: "Learn the basics of Ruby programming language",
      position: 1,
      course: courses(:ruby_course),
      video_url: ""
    )
    assert lesson.valid?
  end

  test "should reject invalid video URL" do
    lesson = Lesson.new(
      title: "Introduction to Ruby",
      content: "Learn the basics of Ruby programming language",
      position: 1,
      course: courses(:ruby_course),
      video_url: "invalid-url"
    )
    assert_not lesson.valid?
    assert_includes lesson.errors[:video_url], "is invalid"
  end

  test "should belong to course" do
    lesson = lessons(:ruby_intro)
    assert_respond_to lesson, :course
    assert_kind_of Course, lesson.course
  end

  test "should have many lesson_completions" do
    lesson = lessons(:ruby_intro)
    assert_respond_to lesson, :lesson_completions
    assert_kind_of ActiveRecord::Associations::CollectionProxy, lesson.lesson_completions
  end

  test "should have many completed_by_users through lesson_completions" do
    lesson = lessons(:ruby_intro)
    assert_respond_to lesson, :completed_by_users
    assert_kind_of ActiveRecord::Associations::CollectionProxy, lesson.completed_by_users
  end

  test "should destroy associated lesson_completions when lesson is deleted" do
    lesson = lessons(:ruby_intro)
    # Create a lesson completion
    LessonCompletion.create!(user: users(:student), lesson: lesson)
    completion_count = lesson.lesson_completions.count
    assert completion_count > 0
    lesson.destroy
    assert_equal 0, LessonCompletion.where(lesson: lesson).count
  end

  test "ordered scope should return lessons ordered by position" do
    course = Course.create!(title: "Test Course", description: "Test course for ordering", duration: 30, instructor: users(:instructor))
    lesson1 = course.lessons.create!(title: "Lesson 1", content: "This is lesson content 1", position: 3)
    lesson2 = course.lessons.create!(title: "Lesson 2", content: "This is lesson content 2", position: 1)
    lesson3 = course.lessons.create!(title: "Lesson 3", content: "This is lesson content 3", position: 2)

    ordered_lessons = course.lessons.ordered
    assert_equal [ lesson2, lesson3, lesson1 ], ordered_lessons.to_a
  end

  test "completed_by? should return true when user has completed lesson" do
    lesson = lessons(:ruby_intro)
    student = users(:student)

    LessonCompletion.create!(user: student, lesson: lesson)
    assert lesson.completed_by?(student)
  end

  test "completed_by? should return false when user has not completed lesson" do
    lesson = lessons(:ruby_intro)
    student = users(:student)

    # Make sure no completion exists
    LessonCompletion.where(user: student, lesson: lesson).destroy_all
    assert_not lesson.completed_by?(student)
  end

  test "next_lesson should return next lesson in course" do
    course = Course.create!(title: "Test Course", description: "Test course for navigation", duration: 30, instructor: users(:instructor))
    lesson1 = course.lessons.create!(title: "Lesson 1", content: "This is lesson content 1", position: 1)
    lesson2 = course.lessons.create!(title: "Lesson 2", content: "This is lesson content 2", position: 2)
    lesson3 = course.lessons.create!(title: "Lesson 3", content: "This is lesson content 3", position: 3)

    assert_equal lesson2, lesson1.next_lesson
    assert_equal lesson3, lesson2.next_lesson
    assert_nil lesson3.next_lesson
  end

  test "previous_lesson should return previous lesson in course" do
    course = Course.create!(title: "Test Course", description: "Test course for navigation", duration: 30, instructor: users(:instructor))
    lesson1 = course.lessons.create!(title: "Lesson 1", content: "This is lesson content 1", position: 1)
    lesson2 = course.lessons.create!(title: "Lesson 2", content: "This is lesson content 2", position: 2)
    lesson3 = course.lessons.create!(title: "Lesson 3", content: "This is lesson content 3", position: 3)

    assert_nil lesson1.previous_lesson
    assert_equal lesson1, lesson2.previous_lesson
    assert_equal lesson2, lesson3.previous_lesson
  end

  test "next_lesson should work with non-sequential positions" do
    course = Course.create!(title: "Test Course", description: "Test course for navigation", duration: 30, instructor: users(:instructor))
    lesson1 = course.lessons.create!(title: "Lesson 1", content: "This is lesson content 1", position: 10)
    lesson2 = course.lessons.create!(title: "Lesson 2", content: "This is lesson content 2", position: 20)
    lesson3 = course.lessons.create!(title: "Lesson 3", content: "This is lesson content 3", position: 30)

    assert_equal lesson2, lesson1.next_lesson
    assert_equal lesson3, lesson2.next_lesson
    assert_nil lesson3.next_lesson
  end

  test "previous_lesson should work with non-sequential positions" do
    course = Course.create!(title: "Test Course", description: "Test course for navigation", duration: 30, instructor: users(:instructor))
    lesson1 = course.lessons.create!(title: "Lesson 1", content: "This is lesson content 1", position: 10)
    lesson2 = course.lessons.create!(title: "Lesson 2", content: "This is lesson content 2", position: 20)
    lesson3 = course.lessons.create!(title: "Lesson 3", content: "This is lesson content 3", position: 30)

    assert_nil lesson1.previous_lesson
    assert_equal lesson1, lesson2.previous_lesson
    assert_equal lesson2, lesson3.previous_lesson
  end
end
