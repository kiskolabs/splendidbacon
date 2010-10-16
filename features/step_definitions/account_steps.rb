Given /^(?:|I )am not authenticated$/ do
  visit('/users/sign_out')
end

When /^(?:|I )fill and submit registration form/ do
  When %{fill in "user_email" with "test@example.com"}
  And %{fill in "user_name" with "secret agent"}
  And %{fill in "user_password" with "secret"}
  And %{fill in "user_password_confirmation" with "secret"}
  And %{press "Sign up"}
end

Given /^I am authenticated as "([^"]*)"$/ do |email|
  Given %{I have an user with email "#{email}"}
  When %{I go to login page}
  And %{fill in "user_email" with "#{email}"}
  And %{fill in "user_password" with "secret"}
  And %{press "Sign in"}
end


Given /^(?:|I )have an user with email "([^"]*)"$/ do |email|
  unless User.exists?(:email => email)
    User.create!(:email => email,
              :name => "secret agent",
              :password => "secret",
              :password_confirmation => "secret")
  end
end