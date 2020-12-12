class RolesController < ApplicationController
  def new
    authorize Role
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

  def access
    @role = Role.find(id)
    @active_ids = @role.role_permissions.active.collect(&:permission_id)
    @permissions = Permission.includes(:action, :resource)
  end

  def empower
    @role = Role.includes(:role_permissions).find(id)
    db_permission_ids = @role.role_permissions.collect { |r_p| r_p.permission_id }

    # inactive [@role, db_permission_ids - permission_ids]
    (db_permission_ids - permission_ids).each do |p_id|
      RolePermission.find_or_create_by(role_id: id, permission_id: p_id).inactive!
    end

    # active [@role, permission_ids]
    permission_ids.each do |p_id|
      RolePermission.find_or_create_by(role_id: id, permission_id: p_id).active!
    end

    redirect_to access_role_path(@role)
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

  def id
    params[:id]
  end

  def permission_ids
    (params[:permission_ids] || []).collect(&:to_i)
  end
end
