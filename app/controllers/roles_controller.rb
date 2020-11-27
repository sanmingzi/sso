class RolesController < ApplicationController
  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      flash[:success] = 'Create role success!'
      redirect_to roles_path
    else
      flash[:notice] = 'Create role failed'
      respond_to do |format|
        format.js
      end
    end
  end

  def index
    @roles = Role.all
  end

  def show
    @role = Role.find(id)
  end

  def edit
    @role = Role.find(id)
  end

  def update
    @role = Role.find(id)
    if @role.update(role_params)
      flash[:success] = "Update role (ID = #{id}) success"
      redirect_to roles_path
    else
      flash[:alert] = "Update role (ID = #{id}) failed"
      respond_to do |format|
        format.js
      end
    end
  end

  def authorize
    @role = Role.find(id)
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def id
    params[:id]
  end
end
