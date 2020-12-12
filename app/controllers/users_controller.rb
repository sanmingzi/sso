class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'You have sign up successfully!'
      redirect_to root_path
    else
      flash[:alert] = 'Sign up failed'
      respond_to do |format|
        format.js
      end
    end
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

  def edit
    @user = User.find(id)
  end

  def update
    @user = User.find(id)
    if @user.update!(user_params)
      flash[:success] = "Update user #{@user.username} (ID = #{id}) success"
      redirect_to users_path
    else
      flash[:alert] = "Update user #{@user.username} (ID = #{id}) failed"
      respond_to do |format|
        format.js
      end
    end
  end

  def access
    @user = User.find(id)
    @roles = Role.active
    @active_role_ids = @user.user_roles.active.collect(&:role_id)
  end

  def empower
    @user = User.find(id)
    db_role_ids = @user.user_roles.active.collect(&:role_id)

    # inactive user_role
    (db_role_ids - role_ids).each do |role_id|
      UserRole.find_or_create_by(user_id: id, role_id: role_id).inactive!
    end

    # active user_role
    role_ids.each do |role_id|
      UserRole.find_or_create_by(user_id: id, role_id: role_id).active!
    end

    flash[:success] = "Authorize user #{@user.username} (ID = #{id}) success"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def id
    params[:id]
  end

  def role_ids
    (params[:role_ids] || []).collect(&:to_id)
  end
end
