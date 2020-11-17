class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]

  def new
  end

  def create
    login_name, password = params[:login_name], params[:password]
    user = User.find_by_username(login_name) || User.find_by_email(login_name)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      flash[:notice] = 'Logged in!'
      redirect_to root_path
    else
      flash[:alert] = 'Login Name or Password Invalid'
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Logged out!'
  end
end
