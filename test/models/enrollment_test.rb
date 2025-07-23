require "test_helper"

class EnrollmentTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    enrollment = Enrollment.new(
      user: users(:student),
      course: courses(:ruby_course)
    )
    assert enrollment.valid?
  end

  test "should require user" do
    enrollment = Enrollment.new(course: courses(:ruby_course))
    assert_not enrollment.valid?
    assert_includes enrollment.errors[:user], "must exist"
  end

  test "should require course" do
    enrollment = Enrollment.new(user: users(:student))
    assert_not enrollment.valid?
    assert_includes enrollment.errors[:course], "must exist"
  end

  test "should require unique user per course" do
    # Create first enrollment
    Enrollment.create!(user: users(:student), course: courses(:ruby_course))
    
    # Try to create duplicate enrollment
    duplicate_enrollment = Enrollment.new(user: users(:student), course: courses(:ruby_course))
    assert_not duplicate_enrollment.valid?
    assert_includes duplicate_enrollment.errors[:user_id], "is already enrolled in this course"
  end

  test "should allow same user to enroll in different courses" do
    # Create second course
    course2 = Course.create!(
      title: "JavaScript Course",
      description: "Learn JavaScript programming",
      duration: 30,
      instructor: users(:instructor)
    )
    
    # Create first enrollment
    enrollment1 = Enrollment.create!(user: users(:student), course: courses(:ruby_course))
    
    # Create second enrollment with same user, different course
    enrollment2 = Enrollment.new(user: users(:student), course: course2)
    assert enrollment2.valid?
  end

  test "should allow different users to enroll in same course" do
    # Create second student
    student2 = User.create!(
      name: "Jane Doe",
      email: "jane@example.com",
      role: "student",
      password: "password123"
    )
    
    # Create first enrollment
    enrollment1 = Enrollment.create!(user: users(:student), course: courses(:ruby_course))
    
    # Create second enrollment with different user, same course
    enrollment2 = Enrollment.new(user: student2, course: courses(:ruby_course))
    assert enrollment2.valid?
  end

  test "should belong to user" do
    enrollment = enrollments(:student_ruby_enrollment)
    assert_respond_to enrollment, :user
    assert_kind_of User, enrollment.user
  end

  test "should belong to course" do
    enrollment = enrollments(:student_ruby_enrollment)
    assert_respond_to enrollment, :course
    assert_kind_of Course, enrollment.course
  end

  test "should set enrolled_at before create" do
    enrollment = Enrollment.new(
      user: users(:student),
      course: courses(:ruby_course)
    )
    
    assert_nil enrollment.enrolled_at
    enrollment.save!
    assert_not_nil enrollment.enrolled_at
    assert_kind_of Time, enrollment.enrolled_at
  end

  test "should not override enrolled_at if already set" do
    specific_time = 1.day.ago
    enrollment = Enrollment.new(
      user: users(:student),
      course: courses(:ruby_course),
      enrolled_at: specific_time
    )
    
    enrollment.save!
    assert_equal specific_time.to_i, enrollment.enrolled_at.to_i
  end

  test "recent scope should return enrollments ordered by enrolled_at desc" do
    # Create enrollments with different times
    enrollment1 = Enrollment.create!(
      user: users(:student),
      course: courses(:ruby_course),
      enrolled_at: 3.days.ago
    )
    
    # Create second course for second enrollment
    course2 = Course.create!(
      title: "JavaScript Course",
      description: "Learn JavaScript programming",
      duration: 30,
      instructor: users(:instructor)
    )
    
    enrollment2 = Enrollment.create!(
      user: users(:student),
      course: course2,
      enrolled_at: 1.day.ago
    )
    
    # Create third course for third enrollment
    course3 = Course.create!(
      title: "Python Course",
      description: "Learn Python programming",
      duration: 35,
      instructor: users(:instructor)
    )
    
    enrollment3 = Enrollment.create!(
      user: users(:student),
      course: course3,
      enrolled_at: 2.days.ago
    )
    
    recent_enrollments = Enrollment.recent
    assert_equal [enrollment2, enrollment3, enrollment1], recent_enrollments.to_a
  end

  test "should use current time for enrolled_at if not provided" do
    freeze_time = Time.current
    
    travel_to freeze_time do
      enrollment = Enrollment.create!(
        user: users(:student),
        course: courses(:ruby_course)
      )
      
      assert_equal freeze_time.to_i, enrollment.enrolled_at.to_i
    end
  end

  test "set_enrolled_at should only set if enrolled_at is nil" do
    enrollment = Enrollment.new(
      user: users(:student),
      course: courses(:ruby_course)
    )
    
    # Mock the callback being called
    enrollment.send(:set_enrolled_at)
    first_time = enrollment.enrolled_at
    
    # Call again - should not change
    enrollment.send(:set_enrolled_at)
    assert_equal first_time, enrollment.enrolled_at
  end
end
