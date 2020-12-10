class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate
  helper_method :current_user, :is_login?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def is_login?
    current_user.present?
  end

  private

  def authenticate
    redirect_to login_path unless is_login?
  end
end
