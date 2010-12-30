class Api::V1::StatusesController < Api::BaseController
  respond_to :json, :xml
  
  def index
    organization = current_user.organizations.find(params[:organization_id])
    project = organization.projects.find(params[:project_id])
    respond_with(project.statuses)
  end
end
