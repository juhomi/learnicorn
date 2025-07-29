class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = root_url
    mail(to: @user.email, subject: "Welcome to Learning Platform!")
  end

  def course_enrollment_confirmation(user, course)
    @user = user
    @course = course
    @course_url = student_course_url(@course)
    mail(to: @user.email, subject: "Enrolled in #{@course.title}")
  end

  def lesson_completion_notification(user, lesson)
    @user = user
    @lesson = lesson
    @course = lesson.course
    @course_url = student_course_url(@course)
    mail(to: @user.email, subject: "Lesson completed: #{@lesson.title}")
  end

  def course_published_notification(course)
    @course = course
    @course_url = course_url(@course)

    # Send to all students
    User.student.find_each do |student|
      mail(to: student.email, subject: "New course available: #{@course.title}")
    end
  end
end
