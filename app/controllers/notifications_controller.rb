class NotificationsController < ApplicationController
  before_filter :current_project
  
  def create
    @notification = @project.notifications.find_or_create_by_user_id(current_user.id)
    respond_to do |format|
      format.js
      format.html { redirect_to project_path(@project)}
    end
  end
  
  def destroy
    notification = @project.notifications.where(:user_id => current_user.id).first
    notification.destroy if notification
    respond_to do |format|
      format.js
      format.html { redirect_to project_path(@project)}
    end
  end
  
  protected
  
  def current_project
    @project = Project.find(params[:project_id])
    unless @project.organization.user_ids.include?(current_user.id)
      raise ActiveRecord::RecordNotFound
    end
  end
end
