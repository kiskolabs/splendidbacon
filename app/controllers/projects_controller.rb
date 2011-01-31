class ProjectsController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!, :except => [:guest]
  before_filter :current_project, :only => [:show, :edit, :update, :destroy, :enable_guest_access, :disable_guest_access]

  def show
    title @project.name
    @comment ||= @project.statuses.new
    @notification = @project.notifications.where(:user_id => current_user.id).first
  end

  def guest
    @project = Project.find(params[:id])
    unless @project.authenticate_guest_access(params[:token])
      # TODO Actually show the flash message on front page.
      redirect_to root_path, :notice => "You're not allowed to view that project. Please check the link."
    else
      title "[Guest access] #{@project.name}"
      render :layout => "guest"
    end
  end

  def new
    @organization = current_organization
    title "New project for #{@organization.name}"
    @project = Project.new(:state => :ongoing)
  end

  def create
    @organization = current_organization
    @project = @organization.projects.new(params[:project])
    @project.user = current_user
    flash[:notice] = "Project was successfully created." if @project.save
    respond_with @project
  end

  def edit
    title "Edit '#{@project.name}'"
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

  def enable_guest_access
    @project.enable_guest_access
    flash[:notice] = "Guest access was enabled. Link to the guest view is in the sidebar."
    respond_with @project
  end

  def disable_guest_access
    @project.disable_guest_access
    flash[:notice] = "Guest access was disabled. Guest view can't be viewed anymore."
    respond_with @project
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
