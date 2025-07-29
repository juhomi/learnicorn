require "test_helper"

class InstructorMailerTest < ActionMailer::TestCase
  setup do
    @instructor = users(:instructor)
    @student = users(:student)
    @course = courses(:ruby_course)
    @enrollment = Enrollment.create!(user: @student, course: @course)
  end

  test "new_enrollment_notification" do
    mail = InstructorMailer.new_enrollment_notification(@instructor, @enrollment)

    assert_equal "New enrollment in #{@course.title}", mail.subject
    assert_equal [ @instructor.email ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match @instructor.name, mail.body.encoded
    assert_match @student.name, mail.body.encoded
    assert_match @course.title, mail.body.encoded
    assert_match "enrolled", mail.body.encoded.downcase
  end

  test "course_completion_notification" do
    mail = InstructorMailer.course_completion_notification(@instructor, @student, @course)

    assert_equal "#{@student.name} completed #{@course.title}", mail.subject
    assert_equal [ @instructor.email ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match @instructor.name, mail.body.encoded
    assert_match @student.name, mail.body.encoded
    assert_match @course.title, mail.body.encoded
    assert_match "completed", mail.body.encoded.downcase
  end

  test "monthly_report" do
    # Create additional data for the report
    lesson1 = @course.lessons.create!(
      title: "Test Lesson 1",
      content: "Test content 1",
      position: 1
    )
    lesson2 = @course.lessons.create!(
      title: "Test Lesson 2",
      content: "Test content 2",
      position: 2
    )

    mail = InstructorMailer.monthly_report(@instructor, 6, 2024)

    assert_equal "Monthly report for June 2024", mail.subject
    assert_equal [ @instructor.email ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match @instructor.name, mail.body.encoded
    assert_match "June 2024", mail.body.encoded
    assert_match "report", mail.body.encoded.downcase
  end

  test "new_enrollment_notification should include course url" do
    mail = InstructorMailer.new_enrollment_notification(@instructor, @enrollment)

    # Check that the body contains a URL
    assert_match /http/, mail.body.encoded
  end

  test "course_completion_notification should include course url" do
    mail = InstructorMailer.course_completion_notification(@instructor, @student, @course)

    # Check that the body contains a URL
    assert_match /http/, mail.body.encoded
  end

  test "monthly_report should include statistics" do
    # Create additional courses and enrollments
    course2 = Course.create!(
      title: "Course 2",
      description: "Second course",
      duration: 15,
      instructor: @instructor
    )

    student2 = User.create!(
      name: "Student 2",
      email: "student2@example.com",
      password: "password",
      role: "student"
    )

    Enrollment.create!(user: student2, course: course2)

    mail = InstructorMailer.monthly_report(@instructor, 6, 2024)

    # Should include some statistics
    assert_match /student/i, mail.body.encoded
    assert_match /course/i, mail.body.encoded
  end

  test "monthly_report should handle different months" do
    months = [
      [ 1, "January" ],
      [ 2, "February" ],
      [ 3, "March" ],
      [ 4, "April" ],
      [ 5, "May" ],
      [ 6, "June" ],
      [ 7, "July" ],
      [ 8, "August" ],
      [ 9, "September" ],
      [ 10, "October" ],
      [ 11, "November" ],
      [ 12, "December" ]
    ]

    months.each do |month_num, month_name|
      mail = InstructorMailer.monthly_report(@instructor, month_num, 2024)

      assert_equal "Monthly report for #{month_name} 2024", mail.subject
      assert_match month_name, mail.body.encoded
    end
  end

  test "mailer should handle instructor with long name" do
    long_name_instructor = User.create!(
      name: "A" * 100,
      email: "longinstructor@example.com",
      password: "password",
      role: "instructor"
    )

    mail = InstructorMailer.new_enrollment_notification(long_name_instructor, @enrollment)

    assert_equal "New enrollment in #{@course.title}", mail.subject
    assert_equal [ long_name_instructor.email ], mail.to
    assert_match long_name_instructor.name, mail.body.encoded
  end

  test "mailer should handle student with special characters" do
    special_student = User.create!(
      name: "José María Ñoño",
      email: "special@example.com",
      password: "password",
      role: "student"
    )

    special_enrollment = Enrollment.create!(user: special_student, course: @course)

    mail = InstructorMailer.new_enrollment_notification(@instructor, special_enrollment)

    assert_equal "New enrollment in #{@course.title}", mail.subject
    assert_equal [ @instructor.email ], mail.to
    assert_match special_student.name, mail.body.encoded
  end

  test "course_completion_notification should handle edge cases" do
    # Test with minimal course data
    minimal_course = Course.create!(
      title: "A",
      description: "A" * 10,
      duration: 1,
      instructor: @instructor
    )

    mail = InstructorMailer.course_completion_notification(@instructor, @student, minimal_course)

    assert_equal "#{@student.name} completed #{minimal_course.title}", mail.subject
    assert_equal [ @instructor.email ], mail.to
    assert_match minimal_course.title, mail.body.encoded
  end

  test "monthly_report should handle instructor with no courses" do
    instructor_no_courses = User.create!(
      name: "New Instructor",
      email: "newinstructor@example.com",
      password: "password",
      role: "instructor"
    )

    mail = InstructorMailer.monthly_report(instructor_no_courses, 6, 2024)

    assert_equal "Monthly report for June 2024", mail.subject
    assert_equal [ instructor_no_courses.email ], mail.to
    assert_match instructor_no_courses.name, mail.body.encoded
  end
end
