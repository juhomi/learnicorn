require 'test_helper'

class LessonCompletionJobTest < ActiveJob::TestCase
  setup do
    @user = users(:student)
    @course = courses(:ruby_course)
    @lesson = lessons(:ruby_intro)
    @instructor = users(:instructor)
  end

  test "should be enqueued" do
    assert_enqueued_jobs 1 do
      LessonCompletionJob.perform_later(@user.id, @lesson.id)
    end
  end

  test "should send lesson completion notification" do
    # At minimum, should send lesson completion notification
    assert_emails 1 do
      LessonCompletionJob.perform_now(@user.id, @lesson.id)
    end
  end

  test "should send course completion notification when course is completed" do
    # Mock the course completion check to return true
    @course.stub :completed_by?, true do
      assert_emails 2 do # lesson completion + course completion
        LessonCompletionJob.perform_now(@user.id, @lesson.id)
      end
    end
  end

  test "should not send course completion notification when course is not completed" do
    # Mock the course completion check to return false
    @course.stub :completed_by?, false do
      assert_emails 1 do # only lesson completion
        LessonCompletionJob.perform_now(@user.id, @lesson.id)
      end
    end
  end

  test "should handle user not found" do
    assert_raises(ActiveRecord::RecordNotFound) do
      LessonCompletionJob.perform_now(999999, @lesson.id)
    end
  end

  test "should handle lesson not found" do
    assert_raises(ActiveRecord::RecordNotFound) do
      LessonCompletionJob.perform_now(@user.id, 999999)
    end
  end

  test "should queue to default queue" do
    assert_equal :default, LessonCompletionJob.new.queue_name
  end

  test "should send lesson completion email to user" do
    mock_user_mailer = Minitest::Mock.new
    mock_user_mailer.expect :deliver_now, nil
    
    UserMailer.stub :lesson_completion_notification, mock_user_mailer do
      # Mock course completion to false to avoid instructor email
      @course.stub :completed_by?, false do
        LessonCompletionJob.perform_now(@user.id, @lesson.id)
      end
    end
    
    mock_user_mailer.verify
  end

  test "should send course completion email to instructor when course completed" do
    mock_instructor_mailer = Minitest::Mock.new
    mock_instructor_mailer.expect :deliver_now, nil
    
    InstructorMailer.stub :course_completion_notification, mock_instructor_mailer do
      mock_user_mailer = Minitest::Mock.new
      mock_user_mailer.expect :deliver_now, nil
      
      UserMailer.stub :lesson_completion_notification, mock_user_mailer do
        @course.stub :completed_by?, true do
          LessonCompletionJob.perform_now(@user.id, @lesson.id)
        end
      end
    end
    
    mock_instructor_mailer.verify
  end

  test "should work with different lessons" do
    # Create another lesson
    another_lesson = @course.lessons.create!(
      title: 'Another Lesson',
      content: 'Another lesson content',
      position: 2
    )
    
    assert_emails 1 do
      LessonCompletionJob.perform_now(@user.id, another_lesson.id)
    end
  end

  test "should handle lesson from different course" do
    # Create different instructor and course
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
    
    different_lesson = different_course.lessons.create!(
      title: 'Different Lesson',
      content: 'Different lesson content',
      position: 1
    )
    
    assert_emails 1 do
      LessonCompletionJob.perform_now(@user.id, different_lesson.id)
    end
  end

  test "should handle multiple users completing same lesson" do
    # Create another user
    another_user = User.create!(
      name: 'Another Student',
      email: 'another@example.com',
      password: 'password',
      role: 'student'
    )
    
    # Both users should be able to complete the same lesson
    assert_emails 1 do
      LessonCompletionJob.perform_now(@user.id, @lesson.id)
    end
    
    assert_emails 1 do
      LessonCompletionJob.perform_now(another_user.id, @lesson.id)
    end
  end

  test "should be retryable on failure" do
    job = LessonCompletionJob.new(@user.id, @lesson.id)
    assert_respond_to job, :retry_job
  end

  test "should handle job serialization" do
    job = LessonCompletionJob.new(@user.id, @lesson.id)
    serialized = job.serialize
    
    assert_equal 'LessonCompletionJob', serialized['job_class']
    assert_equal [@user.id, @lesson.id], serialized['arguments']
  end

  test "should enqueue with delay" do
    assert_enqueued_jobs 1 do
      LessonCompletionJob.set(wait: 1.hour).perform_later(@user.id, @lesson.id)
    end
  end

  test "should handle edge case with course completion logic" do
    # Create a course with multiple lessons
    lesson1 = @course.lessons.create!(title: 'Lesson 1', content: 'Content 1', position: 1)
    lesson2 = @course.lessons.create!(title: 'Lesson 2', content: 'Content 2', position: 2)
    
    # Complete first lesson - should not trigger course completion
    @course.stub :completed_by?, false do
      assert_emails 1 do
        LessonCompletionJob.perform_now(@user.id, lesson1.id)
      end
    end
    
    # Complete second lesson - should trigger course completion
    @course.stub :completed_by?, true do
      assert_emails 2 do
        LessonCompletionJob.perform_now(@user.id, lesson2.id)
      end
    end
  end

  test "should handle nil course instructor" do
    # Create a course with nil instructor (edge case)
    orphan_course = Course.create!(
      title: 'Orphan Course',
      description: 'Course with no instructor',
      duration: 10,
      instructor: nil
    )
    
    orphan_lesson = orphan_course.lessons.create!(
      title: 'Orphan Lesson',
      content: 'Lesson content',
      position: 1
    )
    
    # Should still send user notification, but may fail on instructor notification
    assert_raises(NoMethodError) do
      orphan_course.stub :completed_by?, true do
        LessonCompletionJob.perform_now(@user.id, orphan_lesson.id)
      end
    end
  end
end