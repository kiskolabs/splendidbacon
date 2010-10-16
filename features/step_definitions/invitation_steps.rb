Given /^have received invite to "([^"]*)" with token "([^"]*)" to organization "([^"]*)"$/ do |email, token, organization_name|
  if Organization.exists?(:name => organization_name)
    organization = Organization.where(:name => organization_name).first
  else
    organization = Organization.create(:name => organization_name)
  end
  Invitation.create(:email => email, :token => token, :organization_id => organization.id)
end


Given /^user "([^"]*)" exists with access to organization "([^"]*)" and project "([^"]*)"$/ do |email, organization_name, project_name|
  if User.exists?(:email => email)
    user = User.where(:email => email).first
  else
    user = User.create!(:email => email, :password => "secret", :password_confirmation => "secret", :name => "Secret Agent")
  end
  
  if Organization.exists?(:name => organization_name)
    organization = Organization.where(:name => organization_name).first
  else
    organization = Organization.create!(:name => organization_name)
  end
  Membership.create!(:user_id => user.id, :organization_id => organization.id)
  
  if Project.exists?(:name => project_name)
    project = Project.where(:name => project_name).first
  else
    project = Project.create!(:name => project_name, :start => Time.now-1.days, :end => Time.now+2.months, :organization_id => organization.id)
  end
  
  Participation.create!(:user_id => user.id, :project_id => project.id)
  
end

When /^I click the last remove button$/ do
  with_scope("ul li:last") do
    click_link("Remove")
  end
end

Then /^user "([^"]*)" should not have access to organization "([^"]*)"$/ do |arg1, arg2|
  user = User.where(:email => arg1).first
  organization = Organization.where(:name => arg2).first
  Membership.where(:user_id => user.id, :organization_id => organization.id).size.should == 0
end


Then /^user "([^"]*)" should not have access to project "([^"]*)"$/ do |arg1, arg2|
  user = User.where(:email => arg1).first
  project = Project.where(:name => arg2).first
  Participation.where(:user_id => user.id, :project_id => project.id).size.should == 0
end

