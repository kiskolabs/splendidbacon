require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Invites" do
  background do
    @al = User.create(:email => "al@kiskolabs.com", :name => "Al", :password => "12345678")
    @bob = User.create(:email => "bob@kiskolabs.com", :name => "Bob", :password => "12345678")

    @kisko = @al.organizations.create(:name => "Kisko Labs")
  end
  
  scenario "Creating a new invite", :js => true do
    login_as(@al, :password => "12345678")
    visit organization_page(@kisko.id)
    find(:css, "#organization_nav h1 a").click
    fill_in "invitation_email", :with => "foo@foo.com"
    click_button "Send"
    page.should have_content("Invitation sent to foo@foo.com")
  end
  
  scenario "Accepting an invite as a user" do
    invite = Invitation.create(:email => @bob.email, :organization => @kisko)
    
    login_as(@bob, :password => "12345678")
    visit accept_invitation_page(invite.token)
    click_button "Accept invitation"
    page.should have_content("You are now a part of #{invite.organization.name}")
  end
  
  scenario "Accepting an invite as a visitor" do
    invite = Invitation.create(:email => "alice@random.org", :organization => @kisko)
    visit accept_invitation_page(invite.token)
    page.should have_content("You need to sign in or sign up before continuing.")
  end
  
  scenario "Removing membership", :js => true do
    @kisko.users << @bob
    @kisko.save
    member = @kisko.memberships.where(:user_id => @bob.id).first
    
    login_as(@al, :password => "12345678")
    visit organization_edit_page(@kisko.id)
    find(:xpath, "//li[@id='member_#{member.id}']/span/a").click
    
    alert = page.driver.browser.switch_to.alert
    if alert.text == 'Are you sure you want to remove this user from the organization?'
      alert.accept
    else
      alert.dismiss
    end
    
    Capybara.default_wait_time = 10
    page.should have_no_xpath("//li[@id='member_#{member.id}']")
    Capybara.default_wait_time = 5
  end
end