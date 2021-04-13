class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
    @redirect_url = redirect_url
  end

  # domain.com/login
  # domain.com/login?redirect_url=http://www.google.com
  def create
    login_name, password = params[:login_name], params[:password]
    user = User.find_by_username(login_name) || User.find_by_email(login_name)
    if user && user.authenticate(password)
      session[:user] = [:id, :username, :email].inject({}) { |rtn, attr| rtn[attr] = user[attr]; rtn }
      session[:roles] = user.user_roles.active.collect(&:role_name)
      session[:permissions] = user.role_permissions.active.collect(&:permission_name)
      flash[:notice] = 'Logged in!'
      Rails.cache.write("#{user.id}_session_id", session.id)
      redirect_to (redirect_url || root_url)
    else
      flash[:alert] = 'Login Name or Password Invalid'
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    session[:user] = nil
    redirect_to (redirect_url || login_path), notice: 'Logged out!'
  end

  private
    def redirect_url
      params[:redirect_url]
    end
end
