require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    user = User.new(
      name: "John Doe",
      email: "john@example.com",
      role: "student",
      password: "password123"
    )
    assert user.valid?
  end

  test "should require name" do
    user = User.new(email: "john@example.com", role: "student", password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test "should require name to be at least 2 characters" do
    user = User.new(name: "J", email: "john@example.com", role: "student", password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:name], "is too short (minimum is 2 characters)"
  end

  test "should require name to be at most 50 characters" do
    user = User.new(name: "a" * 51, email: "john@example.com", role: "student", password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:name], "is too long (maximum is 50 characters)"
  end

  test "should require email" do
    user = User.new(name: "John Doe", role: "student", password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test "should require unique email" do
    user1 = users(:instructor)
    user2 = User.new(name: "Jane Doe", email: user1.email, role: "student", password: "password123")
    assert_not user2.valid?
    assert_includes user2.errors[:email], "has already been taken"
  end

  test "should require valid email format" do
    user = User.new(name: "John Doe", email: "invalid-email", role: "student", password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:email], "is invalid"
  end

  test "should require role" do
    user = User.new(name: "John Doe", email: "john@example.com", password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:role], "can't be blank"
  end

  test "should require password_digest" do
    user = User.new(name: "John Doe", email: "john@example.com", role: "student")
    assert_not user.valid?
    assert_includes user.errors[:password_digest], "can't be blank"
  end

  test "should require password_digest to be at least 6 characters" do
    user = User.new(name: "John Doe", email: "john@example.com", role: "student", password: "12345")
    assert_not user.valid?
    assert_includes user.errors[:password_digest], "is too short (minimum is 6 characters)"
  end

  test "should have student role by default" do
    user = User.new(name: "John Doe", email: "john@example.com", password: "password123")
    assert_equal "student", user.role
  end

  test "should have instructor role" do
    user = User.new(name: "John Doe", email: "john@example.com", role: "instructor", password: "password123")
    assert_equal "instructor", user.role
  end

  test "should have admin role" do
    user = User.new(name: "John Doe", email: "john@example.com", role: "admin", password: "password123")
    assert_equal "admin", user.role
  end

  test "admin? should return true for admin users" do
    user = users(:admin)
    assert user.admin?
  end

  test "admin? should return false for non-admin users" do
    user = users(:student)
    assert_not user.admin?
  end

  test "instructor? should return true for instructor users" do
    user = users(:instructor)
    assert user.instructor?
  end

  test "instructor? should return false for non-instructor users" do
    user = users(:student)
    assert_not user.instructor?
  end

  test "student? should return true for student users" do
    user = users(:student)
    assert user.student?
  end

  test "student? should return false for non-student users" do
    user = users(:instructor)
    assert_not user.student?
  end

  test "authenticate should return true for correct password" do
    user = users(:student)
    assert user.authenticate(user.password_digest)
  end

  test "authenticate should return false for incorrect password" do
    user = users(:student)
    assert_not user.authenticate("wrong_password")
  end

  test "password= should set password_digest" do
    user = User.new
    user.password = "newpassword"
    assert_equal "newpassword", user.password_digest
  end

  test "password_confirmation= should set password_confirmation" do
    user = User.new
    user.password_confirmation = "confirm"
    assert_equal "confirm", user.password_confirmation
  end

  test "should validate password confirmation matches" do
    user = User.new(
      name: "John Doe",
      email: "john@example.com",
      role: "student",
      password: "password123",
      password_confirmation: "different"
    )
    assert_not user.valid?
    assert_includes user.errors[:password_confirmation], "doesn't match password"
  end

  test "should be valid when password confirmation matches" do
    user = User.new(
      name: "John Doe",
      email: "john@example.com",
      role: "student",
      password: "password123",
      password_confirmation: "password123"
    )
    assert user.valid?
  end

  test "should have many courses as instructor" do
    instructor = users(:instructor)
    assert_respond_to instructor, :courses
    assert_kind_of ActiveRecord::Associations::CollectionProxy, instructor.courses
  end

  test "should have many enrollments" do
    student = users(:student)
    assert_respond_to student, :enrollments
    assert_kind_of ActiveRecord::Associations::CollectionProxy, student.enrollments
  end

  test "should have many enrolled_courses through enrollments" do
    student = users(:student)
    assert_respond_to student, :enrolled_courses
    assert_kind_of ActiveRecord::Associations::CollectionProxy, student.enrolled_courses
  end

  test "should have many lesson_completions" do
    student = users(:student)
    assert_respond_to student, :lesson_completions
    assert_kind_of ActiveRecord::Associations::CollectionProxy, student.lesson_completions
  end

  test "should destroy associated courses when instructor is deleted" do
    instructor = users(:instructor)
    course_count = instructor.courses.count
    assert course_count > 0
    instructor.destroy
    assert_equal 0, Course.where(instructor: instructor).count
  end

  test "should destroy associated enrollments when user is deleted" do
    student = users(:student)
    enrollment_count = student.enrollments.count
    assert enrollment_count > 0
    student.destroy
    assert_equal 0, Enrollment.where(user: student).count
  end

  test "should destroy associated lesson_completions when user is deleted" do
    student = users(:student)
    completion_count = student.lesson_completions.count
    assert completion_count > 0
    student.destroy
    assert_equal 0, LessonCompletion.where(user: student).count
  end
end
