class Instructor::DashboardController < ApplicationController
  before_action :require_instructor!
  
  def index
    @my_courses = current_user.courses.includes(:students, :lessons)
    @total_students = current_user.courses.joins(:enrollments).count
    @total_lessons = current_user.courses.joins(:lessons).count
    @recent_enrollments = Enrollment.joins(:course).where(courses: { instructor: current_user }).includes(:user, :course).order(created_at: :desc).limit(10)
  end
end