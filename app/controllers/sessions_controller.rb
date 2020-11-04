class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_username(params[:login_name]) || User.find_by_email(params[:login_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logged in!'
      redirect_to users_path
    else
      flash[:alert] = 'Login Name or Password Invalid'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Logged out!'
  end
end
