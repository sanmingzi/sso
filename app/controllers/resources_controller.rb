class ResourcesController < ApplicationController
  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      flash[:success] = "Create resource #{@resource.name} successfully!"
      redirect_to resources_path
    else
      flash[:alert] = "Create resource #{@resource.name} failed"
      respond_to do |format|
        format.js
      end
    end
  end

  def index
  end

  private

  def resource_params
    params.require(:resource).permit(:name)
  end
end
