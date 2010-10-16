class MembershipsController < ApplicationController
  respond_to :html
  before_filter :authenticate_user!
  
  def destroy
    @membership = Membership.find(params[:id])
    organization = @membership.organization
    user = @membership.user
    if current_user.organizations.include?(organization)
      if @membership.destroy
        organization.projects && organization.projects.each do |project|
          Participation.destroy_all(:user_id => user.id, :project_id => project.id)
        end
      end
      flash[:notice] = "User removed"
      redirect_to edit_organization_path(organization)
    else
      flash[:notice] = "Bad boy!"
      redirect_to root_path
    end
  end
  
end
