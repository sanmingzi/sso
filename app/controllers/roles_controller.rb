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
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end
end
