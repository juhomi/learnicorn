require 'test_helper'
require 'minitest/mock'

class CourseEnrollmentJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper
  setup do
    @user = users(:student)
    @course = courses(:ruby_course)
    @instructor = users(:instructor)
    @enrollment = Enrollment.create!(user: @user, course: @course)
  end

  test "should be enqueued" do
    assert_enqueued_jobs 1 do
      CourseEnrollmentJob.perform_later(@user.id, @course.id)
    end
  end

  test "should send emails to student and instructor" do
    assert_emails 2 do
      CourseEnrollmentJob.perform_now(@user.id, @course.id)
    end
  end

  test "should send enrollment confirmation to student" do
    # Mock the mailer to track calls
    mock_mailer = Minitest::Mock.new
    mock_mailer.expect :deliver_now, nil
    
    UserMailer.stub :course_enrollment_confirmation, mock_mailer do
      mock_instructor_mailer = Minitest::Mock.new
      mock_instructor_mailer.expect :deliver_now, nil
      
      InstructorMailer.stub :new_enrollment_notification, mock_instructor_mailer do
        CourseEnrollmentJob.perform_now(@user.id, @course.id)
      end
    end
    
    mock_mailer.verify
  end

  test "should send notification to instructor" do
    mock_instructor_mailer = Minitest::Mock.new
    mock_instructor_mailer.expect :deliver_now, nil
    
    InstructorMailer.stub :new_enrollment_notification, mock_instructor_mailer do
      mock_user_mailer = Minitest::Mock.new
      mock_user_mailer.expect :deliver_now, nil
      
      UserMailer.stub :course_enrollment_confirmation, mock_user_mailer do
        CourseEnrollmentJob.perform_now(@user.id, @course.id)
      end
    end
    
    mock_instructor_mailer.verify
  end

  test "should handle user not found" do
    assert_raises(ActiveRecord::RecordNotFound) do
      CourseEnrollmentJob.perform_now(999999, @course.id)
    end
  end

  test "should handle course not found" do
    assert_raises(ActiveRecord::RecordNotFound) do
      CourseEnrollmentJob.perform_now(@user.id, 999999)
    end
  end

  test "should queue to default queue" do
    assert_equal "default", CourseEnrollmentJob.new.queue_name
  end

  test "should handle enrollment not found" do
    # Delete the enrollment to simulate the case where it doesn't exist
    @enrollment.destroy
    
    # Should only send one email (to student) when enrollment not found
    assert_emails 1 do
      CourseEnrollmentJob.perform_now(@user.id, @course.id)
    end
  end

  test "should work with different users and courses" do
    # Create another user and course
    another_user = User.create!(
      name: 'Another Student',
      email: 'another@example.com',
      password: 'password',
      role: 'student'
    )
    
    another_course = Course.create!(
      title: 'Another Course',
      description: 'Another course description',
      duration: 20,
      instructor: @instructor
    )
    
    # Create enrollment
    Enrollment.create!(user: another_user, course: another_course)
    
    assert_emails 2 do
      CourseEnrollmentJob.perform_now(another_user.id, another_course.id)
    end
  end

  test "should handle course with different instructor" do
    # Create different instructor
    different_instructor = User.create!(
      name: 'Different Instructor',
      email: 'different@example.com',
      password: 'password',
      role: 'instructor'
    )
    
    different_course = Course.create!(
      title: 'Different Course',
      description: 'Different course description',
      duration: 15,
      instructor: different_instructor
    )
    
    # Create enrollment
    Enrollment.create!(user: @user, course: different_course)
    
    assert_emails 2 do
      CourseEnrollmentJob.perform_now(@user.id, different_course.id)
    end
  end

  test "should be retryable on failure" do
    job = CourseEnrollmentJob.new(@user.id, @course.id)
    assert_respond_to job, :retry_job
  end

  test "should handle job serialization" do
    job = CourseEnrollmentJob.new(@user.id, @course.id)
    serialized = job.serialize
    
    assert_equal 'CourseEnrollmentJob', serialized['job_class']
    assert_equal [@user.id, @course.id], serialized['arguments']
  end

  test "should enqueue with delay" do
    assert_enqueued_jobs 1 do
      CourseEnrollmentJob.set(wait: 5.minutes).perform_later(@user.id, @course.id)
    end
  end

  test "should handle multiple enrollments for same user" do
    # Create another course
    another_course = Course.create!(
      title: 'Another Course',
      description: 'Another course description',
      duration: 20,
      instructor: @instructor
    )
    
    # Create another enrollment
    Enrollment.create!(user: @user, course: another_course)
    
    # Should work for both courses
    assert_emails 2 do
      CourseEnrollmentJob.perform_now(@user.id, another_course.id)
    end
  end
end