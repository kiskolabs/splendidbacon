class Api::V1::StatusesController < Api::BaseController
  respond_to :json
  
  def index
    organization = current_user.organizations.find(params[:organization_id])
    project = organization.projects.find(params[:project_id])
    statuses = params[:limit] ? project.statuses.limit(params[:limit].to_i) : project.statuses.limit(200)
    respond_with(statuses)
  end
end
