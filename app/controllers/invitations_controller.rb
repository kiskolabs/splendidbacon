class InvitationsController < ApplicationController
  respond_to :html, :js
  before_filter :authenticate_user!
  
  def show
    title "Invitation"
    @invitation = Invitation.where(:token => params[:id]).first
    raise ActiveRecord::RecordNotFound if @invitation.nil?
    respond_with(@invitation)
  end
  
  def create
    unless in_demo?
      @invitation = Invitation.new(params[:invitation])
      organization = @invitation.organization
      
      unless current_user.organizations.include?(organization)
        @invitation = nil
      else
        @invitation.save
      end
      respond_with(@invitation)
    end
  end
  
  def update
    @invitation = Invitation.find(params[:id])
    organization = @invitation.organization
    Membership.create(:user_id => current_user.id, :organization_id => @invitation.organization_id) unless current_user.organizations.include?(organization)
    @invitation.destroy
    redirect_to organization, :notice => "You are now a part of #{organization.name}"
  end
  
end
