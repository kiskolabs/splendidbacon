class Api::V1::ProjectsController < Api::BaseController
  respond_to :json, :xml
  
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
    respond_to do |format|
      format.json do
        render :json => @project.to_json(:include => { :users => { :only => [:id, :email, :name] } })
      end
      format.xml do
        render :xml => @project.to_xml(:include => { :users => { :only => [:id, :email, :name] } })
      end
    end
  end
  
  def github
    payload = JSON.parse params["payload"]
    if payload && payload["commits"].count > 0
      payload["commits"].each do |commit|
        user = User.where(:email => commit["author"]["email"]).first
        status = @project.statuses.new(:link => commit["url"], :text => commit["message"], :source => "GitHub")
        status.user = user if user
        status.save
      end
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
