require "test_helper"

class CourseTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    course = Course.new(
      title: "Ruby on Rails",
      description: "Learn Ruby on Rails framework",
      duration: 40,
      instructor: users(:instructor),
      published: true
    )
    assert course.valid?
  end

  test "should require title" do
    course = Course.new(
      description: "Learn Ruby on Rails framework",
      duration: 40,
      instructor: users(:instructor)
    )
    assert_not course.valid?
    assert_includes course.errors[:title], "can't be blank"
  end

  test "should require title to be at least 3 characters" do
    course = Course.new(
      title: "RR",
      description: "Learn Ruby on Rails framework",
      duration: 40,
      instructor: users(:instructor)
    )
    assert_not course.valid?
    assert_includes course.errors[:title], "is too short (minimum is 3 characters)"
  end

  test "should require title to be at most 100 characters" do
    course = Course.new(
      title: "a" * 101,
      description: "Learn Ruby on Rails framework",
      duration: 40,
      instructor: users(:instructor)
    )
    assert_not course.valid?
    assert_includes course.errors[:title], "is too long (maximum is 100 characters)"
  end

  test "should require description" do
    course = Course.new(
      title: "Ruby on Rails",
      duration: 40,
      instructor: users(:instructor)
    )
    assert_not course.valid?
    assert_includes course.errors[:description], "can't be blank"
  end

  test "should require description to be at least 10 characters" do
    course = Course.new(
      title: "Ruby on Rails",
      description: "Short",
      duration: 40,
      instructor: users(:instructor)
    )
    assert_not course.valid?
    assert_includes course.errors[:description], "is too short (minimum is 10 characters)"
  end

  test "should require description to be at most 1000 characters" do
    course = Course.new(
      title: "Ruby on Rails",
      description: "a" * 1001,
      duration: 40,
      instructor: users(:instructor)
    )
    assert_not course.valid?
    assert_includes course.errors[:description], "is too long (maximum is 1000 characters)"
  end

  test "should require duration" do
    course = Course.new(
      title: "Ruby on Rails",
      description: "Learn Ruby on Rails framework",
      instructor: users(:instructor)
    )
    assert_not course.valid?
    assert_includes course.errors[:duration], "can't be blank"
  end

  test "should require duration to be greater than 0" do
    course = Course.new(
      title: "Ruby on Rails",
      description: "Learn Ruby on Rails framework",
      duration: 0,
      instructor: users(:instructor)
    )
    assert_not course.valid?
    assert_includes course.errors[:duration], "must be greater than 0"
  end

  test "should require duration to be at most 500" do
    course = Course.new(
      title: "Ruby on Rails",
      description: "Learn Ruby on Rails framework",
      duration: 501,
      instructor: users(:instructor)
    )
    assert_not course.valid?
    assert_includes course.errors[:duration], "must be less than or equal to 500"
  end

  test "should require instructor" do
    course = Course.new(
      title: "Ruby on Rails",
      description: "Learn Ruby on Rails framework",
      duration: 40
    )
    assert_not course.valid?
    assert_includes course.errors[:instructor], "must exist"
  end

  test "should belong to instructor" do
    course = courses(:ruby_course)
    assert_respond_to course, :instructor
    assert_kind_of User, course.instructor
  end

  test "should have many lessons" do
    course = courses(:ruby_course)
    assert_respond_to course, :lessons
    assert_kind_of ActiveRecord::Associations::CollectionProxy, course.lessons
  end

  test "should have many enrollments" do
    course = courses(:ruby_course)
    assert_respond_to course, :enrollments
    assert_kind_of ActiveRecord::Associations::CollectionProxy, course.enrollments
  end

  test "should have many students through enrollments" do
    course = courses(:ruby_course)
    assert_respond_to course, :students
    assert_kind_of ActiveRecord::Associations::CollectionProxy, course.students
  end

  test "should destroy associated lessons when course is deleted" do
    course = courses(:ruby_course)
    lesson_count = course.lessons.count
    assert lesson_count > 0
    course.destroy
    assert_equal 0, Lesson.where(course: course).count
  end

  test "should destroy associated enrollments when course is deleted" do
    course = courses(:ruby_course)
    enrollment_count = course.enrollments.count
    assert enrollment_count > 0
    course.destroy
    assert_equal 0, Enrollment.where(course: course).count
  end

  test "published scope should return only published courses" do
    published_course = Course.create!(
      title: "Published Course",
      description: "This is a published course",
      duration: 30,
      instructor: users(:instructor),
      published: true
    )
    
    unpublished_course = Course.create!(
      title: "Unpublished Course",
      description: "This is an unpublished course",
      duration: 30,
      instructor: users(:instructor),
      published: false
    )
    
    published_courses = Course.published
    assert_includes published_courses, published_course
    assert_not_includes published_courses, unpublished_course
  end

  test "completion_percentage_for should return 0 for empty course" do
    course = Course.create!(
      title: "Empty Course",
      description: "Course with no lessons",
      duration: 30,
      instructor: users(:instructor)
    )
    
    student = users(:student)
    assert_equal 0, course.completion_percentage_for(student)
  end

  test "completion_percentage_for should calculate correct percentage" do
    course = courses(:ruby_course)
    student = users(:student)
    
    # Assuming course has lessons and some are completed
    total_lessons = course.lessons.count
    completed_lessons = student.lesson_completions.joins(:lesson).where(lessons: { course: course }).count
    
    expected_percentage = (completed_lessons.to_f / total_lessons * 100).round(2)
    assert_equal expected_percentage, course.completion_percentage_for(student)
  end

  test "completed_by? should return false for empty course" do
    course = Course.create!(
      title: "Empty Course",
      description: "Course with no lessons",
      duration: 30,
      instructor: users(:instructor)
    )
    
    student = users(:student)
    assert_not course.completed_by?(student)
  end

  test "completed_by? should return true when all lessons are completed" do
    course = courses(:ruby_course)
    student = users(:student)
    
    # Complete all lessons for the student
    course.lessons.each do |lesson|
      LessonCompletion.find_or_create_by(user: student, lesson: lesson)
    end
    
    assert course.completed_by?(student)
  end

  test "completed_by? should return false when not all lessons are completed" do
    course = courses(:ruby_course)
    student = users(:student)
    
    # Only complete some lessons (not all)
    course.lessons.first(1).each do |lesson|
      LessonCompletion.find_or_create_by(user: student, lesson: lesson)
    end
    
    assert_not course.completed_by?(student) if course.lessons.count > 1
  end
end
