class InvitationsController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!
  
  def show
    @invitation = Invitation.where(:token => params[:id]).first
    respond_with(@invitation)
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    organization = @invitation.organization
    @invitation.token = ActiveSupport::SecureRandom.base64(8).gsub("/","_").gsub(/=+$/,"")
    unless current_user.organizations.include?(organization)
      flash[:notice] = "Bad boy!"
      redirect_to root_path
    else
      if @invitation.save
        redirect_to edit_organization_path(organization), :notice => "Invitation sent succesfully to #{@invitation.email}"
      else
        redirect_to edit_organization_path(organization), :notice => "Invitation not sent, check email address!"
      end
    end
  end
  
  def update
    @invitation = Invitation.find(params[:id])
    organization = @invitation.organization
    Membership.create(:user_id => current_user.id, :organization_id => @invitation.organization_id) unless current_user.organizations.include?(organization)
    @invitation.destroy
    flash[:notice] = "You are now part of #{organization.name}"
    redirect_to organization
  end
  
end
