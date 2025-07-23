class DashboardController < ApplicationController
  def index
    case current_user.role
    when 'admin'
      redirect_to admin_path
    when 'instructor'
      redirect_to instructor_path
    when 'student'
      redirect_to student_path
    else
      redirect_to login_path, alert: 'Invalid user role'
    end
  end
end