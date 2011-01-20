class Api::V1::ProjectsController < Api::BaseController
  before_filter :current_project, :only => [:github, :pivotal_tracker]
  
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

  def pivotal_tracker
    activity = Nokogiri::XML(request.body.read)
    event_type = activity.xpath("/activity/event_type").try(:text)
    if ["story_create", "story_update"].include? event_type
      status = @project.statuses.build(:link => activity.xpath("/activity//story[1]/url").text, 
                                       :text => activity.xpath("/activity/description").text, 
                                       :source => "Pivotal Tracker")
      status.save
    end
    head 200
  end
  
  private
  
  def current_project
    unless @project = Project.where(:id => params[:id], :api_token => params[:token]).first
      raise ActiveRecord::RecordNotFound
    end
  end
end
