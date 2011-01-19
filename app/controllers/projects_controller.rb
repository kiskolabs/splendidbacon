class ProjectsController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!
  before_filter :current_project, :only => [:show, :edit, :update, :destroy]

  def show
    @comment ||= @project.statuses.new
    @notification = @project.notifications.where(:user_id => current_user.id).first
  end

  def new
    @project = Project.new(:state => :ongoing)
    @organization = current_organization
  end

  def create
    @project = current_organization.projects.new(params[:project])
    @organization = current_organization
    if @project.save
      status = @project.statuses.new(:user_id => current_user.id, :text => "Project created", :source => "Comment")
      status.save
      flash[:notice] = "Project was successfully created."
    end
    respond_with @project
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project was successfully updated."
    end
    respond_with @project
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project was successfully deleted."
    redirect_to organization_path(@project.organization)
  end

  private
  
  def current_project
    @project = Project.find(params[:id])
    unless @project.organization.user_ids.include?(current_user.id)
      raise ActiveRecord::RecordNotFound
    end
    @organization = @project.organization
    cookies[:organization] = @organization.id
  end

  def current_organization
    current_user.organizations.find(cookies[:organization])
  rescue ActiveRecord::RecordNotFound
    cookies.delete(:organization)
    flash[:alert] = "You must choose an organization first!"
    redirect_to organizations_path
  end

end
