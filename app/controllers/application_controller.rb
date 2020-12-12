class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate
  helper_method :current_user, :is_login?

  def pundit_user
    UserContext.new(current_user, session)
  end

  def current_user
    if session[:user_id] && is_latest_session?
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

  def is_latest_session?
    session.id.to_s == Rails.cache.read("#{session[:user_id]}_session_id").to_s
  end
end
