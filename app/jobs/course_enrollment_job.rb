class CourseEnrollmentJob < ApplicationJob
  queue_as :default

  def perform(user_id, course_id)
    user = User.find(user_id)
    course = Course.find(course_id)
    
    # Send welcome email to student
    UserMailer.course_enrollment_confirmation(user, course).deliver_now
    
    # Notify instructor about new enrollment
    InstructorMailer.new_enrollment_notification(
      course.instructor, 
      user.enrollments.find_by(course: course)
    ).deliver_now
  end
end