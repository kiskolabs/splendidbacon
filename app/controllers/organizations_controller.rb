class OrganizationsController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!
  before_filter :current_organization, :only => [:timeline, :show, :edit, :update, :destroy]
  
  def timeline
    navigation :timeline
    @projects = @organization.projects
  end

  def show
    navigation :dashboard
    no_background!
  end
  
  def new
    @organization = Organization.new
  end
  
  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      Membership.create!(:user_id => current_user.id, :organization_id => @organization.id)
      flash[:notice] = "Organization was successfully created."
      redirect_to edit_organization_path(@organization)
    else
      respond_with(@organization)
    end
    
  end
  
  def edit
    @invitation = Invitation.new
  end
  
  def update
    if @organization.update_attributes(params[:organization])
      flash[:notice] = "Organization was successfully updated."
    end
    respond_with @organization
  end
  
  def destroy
    @organization.destroy
    flash[:notice] = "Organization was successfully deleted."
    cookies.delete(:organization)
    redirect_to root_path
  end
  
  private

  def current_organization
    @organization = current_user.organizations.readonly(false).find(params[:id])
    cookies[:organization] = @organization.id
  rescue ActiveRecord::RecordNotFound
    cookies.delete(:organization)
    redirect_to root_path
  end
  
end
