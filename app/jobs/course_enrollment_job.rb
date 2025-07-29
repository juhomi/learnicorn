class CourseEnrollmentJob < ApplicationJob
  queue_as :default

  def perform(user_id, course_id)
    user = User.find(user_id)
    course = Course.find(course_id)
    enrollment = user.enrollments.find_by(course: course)

    # Send welcome email to student
    UserMailer.course_enrollment_confirmation(user, course).deliver_now

    # Notify instructor about new enrollment if enrollment exists
    if enrollment
      InstructorMailer.new_enrollment_notification(course.instructor, enrollment).deliver_now
    end
  end
end
