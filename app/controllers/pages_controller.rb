class PagesController < ApplicationController

  def home
    if user_signed_in?
      if organization_id = cookies[:organization]
        redirect_to organization_path(organization_id)
      else
        redirect_to organizations_path
      end
    else
      render
    end
  end

end
