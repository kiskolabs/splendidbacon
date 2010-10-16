Given /^(?:|I )am not authenticated$/ do
  visit('/users/sign_out')
end

When /^(?:|I )fill and submit registration form/ do
  When %{fill in "user_email" with "test@example.com"}
  And %{fill in "user_password" with "secret"}
  And %{fill in "user_password_confirmation" with "secret"}
  And %{press "Sign up"}
end