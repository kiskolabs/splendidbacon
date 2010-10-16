class OrganizationsController < ApplicationController
  respond_to :html

  before_filter :authenticate_user!
  before_filter :current_organization, :only => [:show, :edit, :update, :destroy]
  
  def index
    @organizations = current_user.organizations
  end

  def show
  end
  
  def new
    @organization = Organization.new
  end
  
  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      Membership.create!(:user_id => current_user, :organization_id => @organization)
      flash[:notice] = 'Organization was successfully created.'
    end
    respond_with @organization
  end
  
  def edit
  end
  
  def update
    if @organization.update_attributes(params[:organization])
      flash[:notice] = 'Organization was successfully updated.'
    end
    respond_with @organization
  end
  
  def destroy
    @organization.destroy
    redirect_to(organizations_path)
  end
  
  private

  def current_organization
    @organization = current_user.organizations.readonly(false).find(params[:id])
  end
  
end
