module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end
  
  def sign_in_page
    "/users/sign_in"
  end
  
  def sign_up_page
    "/users/sign_up"
  end
  
  def organization_page(id)
    "/organizations/#{id}"
  end
  
  def organization_edit_page(id)
    organization_page(id) + "/edit"
  end
  
  def project_page(id)
    "/projects/#{id}"
  end
  
  def project_edit_page(id)
    project_page(id) + "/edit"
  end
  
  def accept_invitation_page(token)
    "/invitations/#{token}"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
