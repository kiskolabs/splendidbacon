class Api::V1::UsersController < Api::BaseController
  respond_to :json

  def index
    organization = Organization.find(params[:organization_id])
    respond_to do |format|
      format.json do
        render :json => organization.users.to_json(:only => [:email, :id, :name])
      end
      format.xml do
        render :xml => organization.users.to_xml(:only => [:id, :email, :name])
      end
    end
  end
end
