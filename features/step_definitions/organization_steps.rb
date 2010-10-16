Then /^I should be part of "([^"]*)" organization$/ do |arg1|
  user = User.last
  organization = Organization.where(:name => arg1).first
  user.organizations.include?(organization).should == true
end

Given /^I am part of "([^"]*)" organization$/ do |arg1|
  user = User.last
  organization = Organization.where(:name => arg1).first
  if organization.nil?
    organization = Organization.create(:name => arg1)
  end
  Membership.create!(:user_id => user.id, :organization_id => organization.id)
end

Then /^organization "([^"]*)" should not exist$/ do |arg1|
  Organization.where(:name => arg1).size.should == 0
end
