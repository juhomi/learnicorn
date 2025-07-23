class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :authenticate_user!
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  
  protected
  
  def authenticate_user!
    unless user_signed_in?
      redirect_to login_path, alert: 'Please log in to access this page.'
    end
  end
  
  def user_signed_in?
    current_user.present?
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def require_instructor!
    unless current_user&.instructor?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  def require_student!
    unless current_user&.student?
      redirect_to root_path, alert: 'Access denied.'
    end
  end
  
  helper_method :current_user, :user_signed_in?
  
  private
  
  def record_not_found
    redirect_to root_path, alert: 'The requested resource was not found.'
  end
  
  def parameter_missing
    redirect_to root_path, alert: 'Required parameters are missing.'
  end
end
