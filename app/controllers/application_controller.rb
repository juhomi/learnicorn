class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protect_from_forgery with: :exception, prepend: true

  before_action :authenticate_user!
  before_action :validate_session

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  protected

  def authenticate_user!
    unless user_signed_in?
      redirect_to login_path, alert: "Please log in to access this page."
    end
  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    return @current_user if defined?(@current_user)
    
    @current_user = if session[:user_id]
      begin
        User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        session.delete(:user_id)
        nil
      end
    else
      nil
    end
  end

  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end

  def require_instructor!
    unless current_user&.instructor?
      redirect_to root_path, alert: "Access denied."
    end
  end

  def require_student!
    unless current_user&.student?
      redirect_to root_path, alert: "Access denied."
    end
  end

  helper_method :current_user, :user_signed_in?

  private

  def record_not_found
    redirect_to root_path, alert: "The requested resource was not found."
  end

  def parameter_missing
    redirect_to root_path, alert: "Required parameters are missing."
  end
  
  def validate_session
    if session[:user_id] && !current_user
      session.clear
      redirect_to login_path, alert: "Your session has expired. Please log in again."
    end
  end
  
end
