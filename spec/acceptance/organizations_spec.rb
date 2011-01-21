require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Organizations" do
  background do
    @al = User.create(:email => "al@kiskolabs.com", :name => "Al", :password => "123456")
    
    @kisko = @al.organizations.create(:name => "Kisko Labs")
  end
  
  scenario "If the user has no organizations, they should asked directed to create one" do
    login_as(:user)
    visit homepage
    page.should have_content("Add New Organization")
    fill_in "Name", :with => "Kisko Labs"
    click_button "organization_submit"
    page.should have_content("Kisko Labs")
    page.should have_content("Organization was successfully created.")
  end

  scenario "User can add an organization" do
    login_as @al
    visit organization_path(@kisko.id)
    click_link "Add Organization"
    fill_in "Name", :with => "Octocat Inc."
    click_button "organization_submit"
    page.should have_content("Organization was successfully created.")
  end
  
  scenario "Member can edit an organization" do
    login_as @al
    visit organization_path(@kisko.id)
    find(:css, "#organization_nav h1 a").click
    fill_in "Name", :with => "Not Kisko"
    click_button "organization_submit"
    page.should have_content("Organization was successfully updated.")
    page.should have_content("Not Kisko")
  end
  
  scenario "Member can destroy an organization", :js => true do
    login_as @al
    visit organization_path(@kisko.id)
    find(:css, "#organization_nav h1 a").click
    
    click_button "Delete the organization"
    
    alert = page.driver.browser.switch_to.alert
    if alert.text == 'Are you sure you want delete this organization?'
      alert.accept
    else
      alert.dismiss
    end
    
    page.should have_content("Organization was successfully deleted.")
  end
end
