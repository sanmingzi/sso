class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'You have sign up successfully!'
    else
      flash[:alert] = 'Sign up failed'
    end
    redirect_to users_path
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    @search_key = params[:search_key]
    @users = User.where("username LIKE ? OR email LIKE ?", "%#{@search_key}%", "%#{@search_key}%")
    respond_to do |format|
      format.html { render 'index' }
      format.js
      format.xml { render xml: @users }
      format.json { render json: @users }
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
