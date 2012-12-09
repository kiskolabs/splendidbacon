require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Users" do
  background do
    @al = User.create(:email => "al@kiskolabs.com", :name => "Al", :password => "12345678")
    login_as(@al)
  end

  scenario "Reset password token" do
    visit edit_user_registration_path
    old_token = find_field("Token").value
    
    click_link "Reset authentication token"
    
    page.should have_content("Your API token has been reset")
    new_token = find_field("Token").value
    new_token.should_not == old_token
    old_token = new_token
    
    click_link "Reset authentication token"
    new_token = find_field("Token").value
    new_token.should_not == old_token
  end
end
