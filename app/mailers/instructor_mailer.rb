class InstructorMailer < ApplicationMailer
  def new_enrollment_notification(instructor, enrollment)
    @instructor = instructor
    @enrollment = enrollment
    @student = enrollment.user
    @course = enrollment.course
    @course_url = instructor_course_url(@course)
    mail(to: @instructor.email, subject: "New enrollment in #{@course.title}")
  end

  def course_completion_notification(instructor, user, course)
    @instructor = instructor
    @user = user
    @course = course
    @course_url = instructor_course_url(@course)
    mail(to: @instructor.email, subject: "#{@user.name} completed #{@course.title}")
  end

  def monthly_report(instructor, month, year)
    @instructor = instructor
    @month = month
    @year = year
    @courses = instructor.courses.includes(:students, :lessons)
    @total_students = @courses.joins(:enrollments).count
    @total_lessons = @courses.joins(:lessons).count
    
    mail(to: @instructor.email, subject: "Monthly report for #{Date::MONTHNAMES[month]} #{year}")
  end
end