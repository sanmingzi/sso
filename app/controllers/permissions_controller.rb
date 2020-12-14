class PermissionsController < ApplicationController
  def index
    @permissions = Permission.includes(:action, :resource)
  end

  def search
    search_key = params[:search_key]
    @permissions = Permission.eager_load(:action, :resource).where("actions.name LIKE ? OR resources.name LIKE ?", "%#{search_key}%", "%#{search_key}%")
    respond_to do |format|
      format.js
    end
  end
end
