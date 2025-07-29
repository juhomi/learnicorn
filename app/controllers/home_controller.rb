class HomeController < ApplicationController
  layout "landing"
  skip_before_action :authenticate_user!

  def index
    # Redirect authenticated users to their dashboard
    if user_signed_in?
      redirect_to dashboard_path
      return
    end

    # Landing page - no authentication required
    @total_courses = Course.published.count
    @total_students = User.where(role: "student").count
    @total_instructors = User.where(role: "instructor").count
  end
end
