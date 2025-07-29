class LessonCompletionJob < ApplicationJob
  queue_as :default

  def perform(user_id, lesson_id)
    user = User.find(user_id)
    lesson = Lesson.find(lesson_id)

    # Send completion notification to user
    UserMailer.lesson_completion_notification(user, lesson).deliver_now

    # Check if course is completed
    course = lesson.course
    if course.completed_by?(user)
      # Notify instructor about course completion
      InstructorMailer.course_completion_notification(
        course.instructor,
        user,
        course
      ).deliver_now
    end
  end
end
