class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  
  def new
    @user = User.new
    redirect_to root_path if user_signed_in?
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully!'
    else
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end
end