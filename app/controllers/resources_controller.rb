class ResourcesController < ApplicationController
  def new
    @resource = Resource.new
  end

  def create
    @resource = Resource.new(resource_params)
    ActiveRecord::Base.transaction do
      @resource.save!
      Permission.generate(@resource)
    end
    flash[:success] = "Create resource #{@resource.name} successfully!"
    redirect_to resources_path
  rescue ActiveRecord::RecordInvalid => exception
    flash[:alert] = "Create resource #{@resource.name} failed"
    respond_to do |format|
      format.js
    end
  end

  def index
    @resources = Resource.all
    @resource = Resource.new
  end

  private

  def resource_params
    params.require(:resource).permit(:name)
  end
end
