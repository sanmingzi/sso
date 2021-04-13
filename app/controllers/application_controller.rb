class ApplicationController < ActionController::Base
  include Pundit

  before_action :set_user
  before_action :authenticate
  helper_method :current_user, :is_login?

  def pundit_user
    UserContext.new(@current_user, session)
  end

  def is_login?
    @current_user.present?
  end

  def current_user
    @current_user
  end

  private
    def user_id
      session[:user] && session[:user][:id]
    end

    def set_user
      @current_user = nil
      @current_user ||= User.find(user_id) if user_id && is_latest_session?
    end

    def authenticate
      redirect_to login_path unless is_login?
    end

    def is_latest_session?
      session.id.to_s == Rails.cache.read("#{user_id}_session_id").to_s
    end
end
