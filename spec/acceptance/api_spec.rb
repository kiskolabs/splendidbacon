require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "API Feature" do
  background do
    @al = Factory :user
    @al.reset_authentication_token
    @al.save
    
    @kisko = @al.organizations.create(:name => "Kisko Labs")
    not_kisko = @al.organizations.create(:name => "Not Kisko Labs")
    
    @ongoing = @kisko.projects.create(:name => "Ongoing project", :start => Date.today - 7.days, :end => Date.today + 3.months, :state => :ongoing)
    @ongoing.users << @al
    @ongoing.save
    
    @kisko.projects.create(:name => "On hold project", :start => Date.today - 7.days, :end => Date.today + 3.months, :state => :on_hold)
    
    not_kisko.projects.create(:name => "Ongoing project", :start => Date.today - 7.days, :end => Date.today + 3.months, :state => :ongoing)
  end
  
  scenario "Fails with an invalid token" do
    visit api_v1_organizations_json("INVALID_TOKEN")
    json = JSON.parse(page.body)
    json["error"].should be_present
  end

  scenario "organizations index" do
    visit api_v1_organizations_json(@al.authentication_token)
    json = JSON.parse(page.body)
    
    json.count.should == 2
    
    json.each do |org|
      org["organization"]["id"].should be_present
      Time.parse(org["organization"]["created_at"]).should be_kind_of Time
      Time.parse(org["organization"]["updated_at"]).should be_kind_of Time
      org["organization"]["url"].should match(URI.regexp(["http", "https"]))
    end
    
    json.find { |org| org["organization"]["name"] == "Kisko Labs"}.should be_present
    json.find { |org| org["organization"]["name"] == "Not Kisko Labs"}.should be_present
  end
  
  scenario "organizations show" do
    visit api_v1_organization_json(@al.authentication_token, @kisko.id)
    json = JSON.parse(page.body)
    
    json["organization"]["id"].should be_present
    json["organization"]["name"].should == "Kisko Labs"
    json["organization"]["url"].should match(URI.regexp(["http", "https"]))
  end
  
  scenario "projects index" do
    visit api_v1_organization_projects_json(@al.authentication_token, @kisko.id)
    json = JSON.parse(page.body)
    
    json.count.should == 2
    
    ap json
    
    json.each do |project|
      project["project"]
      project["project"]["id"].should be_present
      project["project"]["name"].should be_present
      project["project"]["state"].should be_present
      project["project"]["url"].should match(URI.regexp(["http", "https"]))
    end
    
    with_users = json.find { |project| project["project"]["name"] == "Ongoing project" }
    with_users["project"]["state"].should == "ongoing"
    with_users["project"]["users"].count.should == 1
    with_users["project"]["users"].first["email"].should == @al.email
    
    
    no_users = json.find { |project| project["project"]["name"] == "On hold project" }
    no_users["project"]["state"].should == "on_hold"
    no_users["project"]["users"].count.should == 0
  end
  
  scenario "projects index, filter by user IDs" do
    visit api_v1_organization_projects_json(@al.authentication_token, @kisko.id, [@al.id])
    json = JSON.parse(page.body)
    
    json.count.should == 1
    json.first["project"]["users"].first["email"].should == @al.email
  end
  
  scenario "projects show" do
    visit api_v1_organization_project_json(@al.authentication_token, @kisko.id, @ongoing.id)
    json = JSON.parse(page.body)
    
    json["project"]["id"].should be_present
    json["project"]["name"].should == "Ongoing project"
    json["project"]["state"].should == "ongoing"
    json["project"]["url"].should match(URI.regexp(["http", "https"]))
    json["project"]["users"].count.should == 1
    json["project"]["users"].find { |user| user["email"] == @al.email }.should be_present
  end
  
  scenario "users index" do
    visit api_v1_organization_users_json(@al.authentication_token, @kisko.id)
    json = JSON.parse(page.body)
    json.count.should == 1
    json.first["user"]["id"].should be_present
    json.first["user"]["name"].should == @al.name
    json.first["user"]["email"].should == @al.email
  end
end
