class Admin::DashboardController < ApplicationController
  before_action :require_admin!

  def index
    @total_users = User.count
    @total_courses = Course.count
    @total_enrollments = Enrollment.count
    @recent_users = User.order(created_at: :desc).limit(5)
    @recent_courses = Course.order(created_at: :desc).limit(5)
    @recent_enrollments = Enrollment.includes(:user, :course).order(created_at: :desc).limit(5)
  end
end
