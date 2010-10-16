class StatusesController < ApplicationController
  before_filter :current_project
  
  respond_to :html
  
  def create
    @comment = @project.statuses.new(params[:status])
    @comment.source = "Comment"
    @comment.user = current_user
    @comment.link = nil
    flash[:notice] = "Comment saved" if @comment.save
    respond_with @comment, :location => project_path(@project)
  end
  
  private
  
  def current_project
    @project = current_user.projects.find(params[:project_id])
  end
end
