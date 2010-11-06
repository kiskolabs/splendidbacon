class Api::V1::OrganizationsController < Api::BaseController
  respond_to :json, :xml
  
  def show
    respond_with(@organization = current_user.organizations.find(params[:id]))
  end
  
  def index
    respond_with(@organizations = current_user.organizations)
  end
end
