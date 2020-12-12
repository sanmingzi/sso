class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
  end

  def create
    login_name, password = params[:login_name], params[:password]
    user = User.find_by_username(login_name) || User.find_by_email(login_name)
    if user && user.authenticate(password)
      session[:user_id] = user.id
      session[:roles] = user.user_roles.active.collect(&:role_name)
      session[:permissions] = user.role_permissions.active.collect(&:permission_name)
      flash[:notice] = 'Logged in!'
      Rails.cache.write("#{user.id}_session_id", session.id)
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
