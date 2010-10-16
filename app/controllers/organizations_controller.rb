class OrganizationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_permissions, :only => [:edit, :update, :destroy]
  
  def index
    @organizations = current_user.organizations
  end
  
  def new
    @organization = Organization.new
  end
  
  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      Membership.create!(:user_id => current_user, :organization_id => @organization)
      redirect_to(@organization, :notice => 'Organization was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def edit

  end
  
  def update
    if @organization.update_attributes(params[:organization])
      redirect_to(@organization, :notice => 'Organization was successfully updated.')
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @organization.destroy
    redirect_to(organizations_path)
  end
  
  private
  
  def check_create_permissions
    @organization = Organization.find(params[:id])
    redirect_to(root_path, :notice => "You're not allowed to touch this organization.") unless current_user.organizations.include?(@organization)
  end
  
end
