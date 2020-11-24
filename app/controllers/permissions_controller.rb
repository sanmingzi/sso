class PermissionsController < ApplicationController
  def index
    @permissions = Permission.includes(:action, :resource)
    puts @permissions.inspect
  end
end
