require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "API Feature" do
  background do
    @al = User.create(:email => "al@kiskolabs.com", :name => "Al", :password => "123456")
    @al.reset_authentication_token
    @al.save
    
    @kisko = @al.organizations.create(:name => "Kisko Labs")
    not_kisko = @al.organizations.create(:name => "Not Kisko Labs")
    
    @ongoing = @kisko.projects.create(:name => "Ongoing project", :start => Date.today - 7.days, :end => Date.today + 3.months, :state => :ongoing)
    @kisko.projects.create(:name => "On hold project", :start => Date.today - 7.days, :end => Date.today + 3.months, :state => :on_hold)
    @ongoing.users << @al
    @ongoing.save
    
    not_kisko.projects.create(:name => "Ongoing project", :start => Date.today - 7.days, :end => Date.today + 3.months, :state => :ongoing)
  end
  
  scenario "Fails with an invalid token" do
    visit "/api/v1/organizations.json?token=INVALID"
    json = JSON.parse page.body
    json["error"].should be_present
  end

  scenario "organizations index" do
    visit "/api/v1/organizations.json?token=#{@al.authentication_token}"
    json = JSON.parse page.body
    
    json.count.should == 2
    
    json.first["organization"]["id"].should be_present
    json.first["organization"]["name"].should == "Kisko Labs"
    json.first["organization"]["url"].should match(URI.regexp(["http", "https"]))
    
    json.second["organization"]["id"].should be_present
    json.second["organization"]["name"].should == "Not Kisko Labs"
    json.second["organization"]["url"].should match(URI.regexp(["http", "https"]))
  end
  
  scenario "organizations show" do
    visit "/api/v1/organizations/#{@kisko.id}.json?token=#{@al.authentication_token}"
    json = JSON.parse page.body
    
    json["organization"]["id"].should be_present
    json["organization"]["name"].should == "Kisko Labs"
    json["organization"]["url"].should match(URI.regexp(["http", "https"]))
  end
  
  scenario "projects index" do
    visit "/api/v1/organizations/#{@kisko.id}/projects.json?token=#{@al.authentication_token}"
    json = JSON.parse page.body
    
    json.count.should == 2
    
    json.first["project"]["id"].should be_present
    json.first["project"]["name"].should == "Ongoing project"
    json.first["project"]["state"].should == "ongoing"
    json.first["project"]["url"].should match(URI.regexp(["http", "https"]))
    json.first["project"]["users"].count.should == 1
    json.first["project"]["users"].first["email"].should == "al@kiskolabs.com"
    
    json.second["project"]["id"].should be_present
    json.second["project"]["name"].should == "On hold project"
    json.second["project"]["state"].should == "on_hold"
    json.second["project"]["url"].should match(URI.regexp(["http", "https"]))
    json.second["project"]["users"].count.should == 0
  end
  
  scenario "projects index, filter by user IDs" do
    visit "/api/v1/organizations/#{@kisko.id}/projects.json?token=#{@al.authentication_token}&users=#{@al.id}"
    json = JSON.parse page.body
    
    json.count.should == 1
    json.first["project"]["users"].first["email"].should == "al@kiskolabs.com"
  end
  
  scenario "projects show" do
    visit "/api/v1/organizations/#{@kisko.id}/projects/#{@ongoing.id}.json?token=#{@al.authentication_token}"
    json = JSON.parse page.body
    
    json["project"]["id"].should be_present
    json["project"]["name"].should == "Ongoing project"
    json["project"]["state"].should == "ongoing"
    json["project"]["url"].should match(URI.regexp(["http", "https"]))
    json["project"]["users"].count == 1
    json["project"]["users"].first["email"].should == "al@kiskolabs.com"
  end
  
  scenario "users index" do
    visit "/api/v1/organizations/#{@kisko.id}/users.json?token=#{@al.authentication_token}"
    json = JSON.parse page.body
    json.count.should == 1
    json.first["user"]["id"].should be_present
    json.first["user"]["name"].should == "Al"
    json.first["user"]["email"].should == "al@kiskolabs.com"
  end
end
