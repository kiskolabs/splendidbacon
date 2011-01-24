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
  
  def api_v1_organizations_json(token)
    "/api/v1/organizations.json?token=#{token}"
  end
  
  def api_v1_organization_json(token, id)
    "/api/v1/organizations/#{id}.json?token=#{token}"
  end
  
  def api_v1_organization_projects_json(token, id, users = [])
    path = "/api/v1/organizations/#{id}/projects.json?token=#{token}"
    path = path + "&users=#{users.join(',')}" unless users.empty?
    path
  end
  
  def api_v1_organization_project_json(token, organization_id, project_id)
    "/api/v1/organizations/#{organization_id}/projects/#{project_id}.json?token=#{token}"
  end
  
  def api_v1_organization_users_json(token, id)
    "/api/v1/organizations/#{id}/users.json?token=#{token}"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
