require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:student)
    @instructor = users(:instructor)
    @course = courses(:ruby_course)
    @lesson = lessons(:ruby_intro)
  end

  test "welcome_email" do
    mail = UserMailer.welcome_email(@user)

    assert_equal "Welcome to Learning Platform!", mail.subject
    assert_equal [ @user.email ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match @user.name, mail.body.encoded
    assert_match "welcome", mail.body.encoded.downcase
  end

  test "course_enrollment_confirmation" do
    mail = UserMailer.course_enrollment_confirmation(@user, @course)

    assert_equal "Enrolled in #{@course.title}", mail.subject
    assert_equal [ @user.email ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match @user.name, mail.body.encoded
    assert_match @course.title, mail.body.encoded
    assert_match "enrolled", mail.body.encoded.downcase
  end

  test "lesson_completion_notification" do
    mail = UserMailer.lesson_completion_notification(@user, @lesson)

    assert_equal "Lesson completed: #{@lesson.title}", mail.subject
    assert_equal [ @user.email ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match @user.name, mail.body.encoded
    assert_match @lesson.title, mail.body.encoded
    assert_match @lesson.course.title, mail.body.encoded
    assert_match "completed", mail.body.encoded.downcase
  end

  test "course_published_notification" do
    # Create additional students
    student1 = User.create!(
      name: "Student 1",
      email: "student1@example.com",
      password: "password",
      role: "student"
    )
    student2 = User.create!(
      name: "Student 2",
      email: "student2@example.com",
      password: "password",
      role: "student"
    )

    # Mock the mail delivery
    deliveries = []
    User.student.find_each do |student|
      mail = UserMailer.course_published_notification(@course)
      mail.to = [ student.email ]
      deliveries << mail
    end

    assert_equal 3, deliveries.count # original student + 2 new students

    # Test the structure of one mail
    mail = deliveries.first
    assert_equal "New course available: #{@course.title}", mail.subject
    assert_equal [ "from@example.com" ], mail.from
    assert_match @course.title, mail.body.encoded
    assert_match "available", mail.body.encoded.downcase
  end

  test "welcome_email should include root url" do
    mail = UserMailer.welcome_email(@user)

    # Check that the body contains a URL
    assert_match /http/, mail.body.encoded
  end

  test "course_enrollment_confirmation should include course url" do
    mail = UserMailer.course_enrollment_confirmation(@user, @course)

    # Check that the body contains a URL
    assert_match /http/, mail.body.encoded
  end

  test "lesson_completion_notification should include course url" do
    mail = UserMailer.lesson_completion_notification(@user, @lesson)

    # Check that the body contains a URL
    assert_match /http/, mail.body.encoded
  end

  test "mailer should handle user with long name" do
    long_name_user = User.create!(
      name: "A" * 100,
      email: "longname@example.com",
      password: "password",
      role: "student"
    )

    mail = UserMailer.welcome_email(long_name_user)

    assert_equal "Welcome to Learning Platform!", mail.subject
    assert_equal [ long_name_user.email ], mail.to
    assert_match long_name_user.name, mail.body.encoded
  end

  test "mailer should handle course with long title" do
    long_title_course = Course.create!(
      title: "A" * 200,
      description: "Test course with very long title",
      duration: 10,
      instructor: @instructor
    )

    mail = UserMailer.course_enrollment_confirmation(@user, long_title_course)

    assert_equal "Enrolled in #{long_title_course.title}", mail.subject
    assert_equal [ @user.email ], mail.to
    assert_match long_title_course.title, mail.body.encoded
  end

  test "mailer should handle special characters in names" do
    special_char_user = User.create!(
      name: "José María Ñoño",
      email: "special@example.com",
      password: "password",
      role: "student"
    )

    mail = UserMailer.welcome_email(special_char_user)

    assert_equal "Welcome to Learning Platform!", mail.subject
    assert_equal [ special_char_user.email ], mail.to
    assert_match special_char_user.name, mail.body.encoded
  end
end
