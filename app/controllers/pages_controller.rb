class PagesController < ApplicationController
  layout "homepage"

  def home
    if user_signed_in?
      flash.keep
      if organization_id = cookies[:organization]
        redirect_to organization_path(organization_id)
      else
        if current_user.organizations.empty?
          redirect_to new_organization_path
        else
          redirect_to organization_path(current_user.organizations.first)
        end
      end
    else
      render
    end
  end

end
