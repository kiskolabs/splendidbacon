class Api::V1::UsersController < Api::BaseController
  respond_to :json
  
  before_filter :authorize_mailchimp, :only => [:mailchimp]
  
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
  
  def mailchimp
    @user = User.where(:email => params["data"]["email"]).first
    case params["type"]
    when "subscribe"
      @user.update_attributes(:newsletter => true) if @user
    when "unsubscribe"
      @user.update_attributes(:newsletter => false) if @user
    when "cleaned"
      @user.update_attributes(:newsletter => false) if @user
    end
    head :ok
  end
  
  protected
  
  def authorize_mailchimp
    if params[:token] == APP_CONFIG["mailchimp"]["token"] && params["data"]["list_id"] == APP_CONFIG["mailchimp"]["list_id"]
      head :ok unless ["subscribe", "unsubscribe", "cleaned"].include?(params["type"])
    else
      head 422
    end
  end
end
