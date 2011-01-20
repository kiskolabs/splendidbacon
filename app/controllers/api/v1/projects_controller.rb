class Api::V1::ProjectsController < Api::BaseController
  respond_to :json
  
  before_filter :current_project, :only => [:github]
  
  def index
    organization = current_user.organizations.find(params[:organization_id])
    @projects = organization.projects  
    @projects = @projects.for_users(params[:users].split(",").map { |id| id.to_i }) if params[:users]
      
    respond_with(@projects)
  end
  
  def show
    organization = current_user.organizations.find(params[:organization_id])
    @project = organization.projects.includes(:users).find(params[:id])
    respond_with(@project)
  end
  
  def github
    Status.create_from_github_payload(params["payload"], @project)
    head :created
  end
  
  private
  
  def current_project
    unless @project = Project.where(:id => params[:id], :api_token => params[:token]).first
      raise ActiveRecord::RecordNotFound
    end
  end
end
