require 'test_helper'

class MonthlyReportJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper
  setup do
    @instructor = users(:instructor)
    @month = 6
    @year = 2024
  end

  test "should be enqueued" do
    assert_enqueued_jobs 1 do
      MonthlyReportJob.perform_later(@month, @year)
    end
  end

  test "should send report to all instructors" do
    # Create additional instructors
    instructor2 = User.create!(
      name: 'Instructor 2',
      email: 'instructor2@example.com',
      password: 'password',
      role: 'instructor'
    )
    
    instructor3 = User.create!(
      name: 'Instructor 3',
      email: 'instructor3@example.com',
      password: 'password',
      role: 'instructor'
    )
    
    # Should send to all 3 instructors
    assert_emails 3 do
      MonthlyReportJob.perform_now(@month, @year)
    end
  end

  test "should not send to non-instructor users" do
    # Create students and admin
    User.create!(
      name: 'Student User',
      email: 'student@example.com',
      password: 'password',
      role: 'student'
    )
    
    User.create!(
      name: 'Admin User',
      email: 'admin@example.com',
      password: 'password',
      role: 'admin'
    )
    
    # Should only send to the original instructor
    assert_emails 1 do
      MonthlyReportJob.perform_now(@month, @year)
    end
  end

  test "should handle no instructors" do
    # Remove all instructors
    User.instructor.destroy_all
    
    assert_emails 0 do
      MonthlyReportJob.perform_now(@month, @year)
    end
  end

  test "should queue to default queue" do
    assert_equal :default, MonthlyReportJob.new.queue_name
  end

  test "should handle different months and years" do
    test_cases = [
      [1, 2024],
      [12, 2023],
      [6, 2025]
    ]
    
    test_cases.each do |month, year|
      assert_emails 1 do
        MonthlyReportJob.perform_now(month, year)
      end
    end
  end

  test "should send emails with correct parameters" do
    mock_mailer = Minitest::Mock.new
    mock_mailer.expect :deliver_now, nil
    
    InstructorMailer.stub :monthly_report, mock_mailer do
      MonthlyReportJob.perform_now(@month, @year)
    end
    
    mock_mailer.verify
  end

  test "should handle large number of instructors" do
    # Create many instructors
    (1..10).each do |i|
      User.create!(
        name: "Instructor #{i}",
        email: "instructor#{i}@example.com",
        password: 'password',
        role: 'instructor'
      )
    end
    
    # Should send to all 11 instructors (original + 10 new)
    assert_emails 11 do
      MonthlyReportJob.perform_now(@month, @year)
    end
  end

  test "should be retryable on failure" do
    job = MonthlyReportJob.new(@month, @year)
    assert_respond_to job, :retry_job
  end

  test "should handle job serialization" do
    job = MonthlyReportJob.new(@month, @year)
    serialized = job.serialize
    
    assert_equal 'MonthlyReportJob', serialized['job_class']
    assert_equal [@month, @year], serialized['arguments']
  end

  test "should enqueue with delay" do
    assert_enqueued_jobs 1 do
      MonthlyReportJob.set(wait: 1.day).perform_later(@month, @year)
    end
  end

  test "should handle edge case months" do
    # Test boundary months
    assert_emails 1 do
      MonthlyReportJob.perform_now(1, 2024) # January
    end
    
    assert_emails 1 do
      MonthlyReportJob.perform_now(12, 2024) # December
    end
  end

  test "should handle invalid month values gracefully" do
    # Depending on implementation, this might need adjustment
    assert_emails 1 do
      MonthlyReportJob.perform_now(0, 2024) # Invalid month
    end
    
    assert_emails 1 do
      MonthlyReportJob.perform_now(13, 2024) # Invalid month
    end
  end

  test "should handle negative year values" do
    assert_emails 1 do
      MonthlyReportJob.perform_now(@month, -1) # Negative year
    end
  end

  test "should handle instructor with no courses" do
    # Create instructor with no courses
    instructor_no_courses = User.create!(
      name: 'Instructor No Courses',
      email: 'nocourses@example.com',
      password: 'password',
      role: 'instructor'
    )
    
    # Should still send reports to all instructors
    assert_emails 2 do # original instructor + new instructor
      MonthlyReportJob.perform_now(@month, @year)
    end
  end

  test "should handle database connection issues" do
    # Mock database error
    User.stub :instructor, -> { raise ActiveRecord::ConnectionNotEstablished.new } do
      assert_raises(ActiveRecord::ConnectionNotEstablished) do
        MonthlyReportJob.perform_now(@month, @year)
      end
    end
  end

  test "should handle instructor email delivery failure" do
    # Mock mailer to raise error
    mock_mailer = Minitest::Mock.new
    mock_mailer.expect :deliver_now, -> { raise Net::SMTPError.new('SMTP Error') }
    
    InstructorMailer.stub :monthly_report, mock_mailer do
      assert_raises(Net::SMTPError) do
        MonthlyReportJob.perform_now(@month, @year)
      end
    end
  end

  test "should process instructors efficiently" do
    # Create many instructors to test batch processing
    (1..100).each do |i|
      User.create!(
        name: "Instructor #{i}",
        email: "instructor#{i}@example.com",
        password: 'password',
        role: 'instructor'
      )
    end
    
    # Should handle large number of instructors without timeout
    assert_emails 101 do # original + 100 new
      Timeout.timeout(5) do # Should complete within 5 seconds
        MonthlyReportJob.perform_now(@month, @year)
      end
    end
  end
end