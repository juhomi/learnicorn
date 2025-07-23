require 'test_helper'

class EmailNotificationJobTest < ActiveJob::TestCase
  setup do
    @user = users(:student)
    @course = courses(:ruby_course)
  end

  test "should be enqueued" do
    assert_enqueued_jobs 1 do
      EmailNotificationJob.perform_later('UserMailer', 'welcome_email', @user)
    end
  end

  test "should execute email sending" do
    assert_emails 1 do
      EmailNotificationJob.perform_now('UserMailer', 'welcome_email', @user)
    end
  end

  test "should handle different mailer classes" do
    assert_emails 1 do
      EmailNotificationJob.perform_now('UserMailer', 'course_enrollment_confirmation', @user, @course)
    end
  end

  test "should handle instructor mailer" do
    instructor = users(:instructor)
    enrollment = Enrollment.create!(user: @user, course: @course)
    
    assert_emails 1 do
      EmailNotificationJob.perform_now('InstructorMailer', 'new_enrollment_notification', instructor, enrollment)
    end
  end

  test "should handle multiple arguments" do
    instructor = users(:instructor)
    
    assert_emails 1 do
      EmailNotificationJob.perform_now('InstructorMailer', 'course_completion_notification', instructor, @user, @course)
    end
  end

  test "should queue to default queue" do
    assert_equal :default, EmailNotificationJob.new.queue_name
  end

  test "should handle mailer method not found" do
    assert_raises(NoMethodError) do
      EmailNotificationJob.perform_now('UserMailer', 'nonexistent_method', @user)
    end
  end

  test "should handle invalid mailer class" do
    assert_raises(NameError) do
      EmailNotificationJob.perform_now('NonexistentMailer', 'some_method', @user)
    end
  end

  test "should handle nil arguments" do
    assert_raises(ArgumentError) do
      EmailNotificationJob.perform_now('UserMailer', 'welcome_email', nil)
    end
  end

  test "should enqueue with correct arguments" do
    job = EmailNotificationJob.new('UserMailer', 'welcome_email', @user)
    assert_equal ['UserMailer', 'welcome_email', @user], job.arguments
  end

  test "should be retryable" do
    job = EmailNotificationJob.new
    assert_respond_to job, :retry_job
  end

  test "should handle job with complex arguments" do
    complex_args = {
      user: @user,
      course: @course,
      options: { send_immediately: true }
    }
    
    assert_enqueued_jobs 1 do
      EmailNotificationJob.perform_later('UserMailer', 'welcome_email', complex_args)
    end
  end

  test "should properly serialize arguments" do
    job = EmailNotificationJob.new('UserMailer', 'welcome_email', @user)
    serialized = job.serialize
    
    assert_equal 'EmailNotificationJob', serialized['job_class']
    assert_equal ['UserMailer', 'welcome_email', @user], serialized['arguments']
  end
end