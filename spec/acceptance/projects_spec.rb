require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Projects" do
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
  
  scenario "Projects are listed for the organization", :js => true do
    login_as(@al)
    visit organization_page(@kisko.id)
    
    page.should have_content("Ongoing project")
    page.should have_content("On hold project")
  end
  
  scenario "Projects can be filtered by state", :js => true do
    login_as(@al)
    visit organization_page(@kisko.id)
    
    find(:xpath, "//a[@data-value='ongoing']").click
    all("div.dimmed") do |dimmed|
      dimmed.should have_content("On Hold")
    end
    
    find(:xpath, "//a[@data-value='on_hold']").click
    all("div.dimmed") do |dimmed|
      dimmed.should have_content("Ongoing")
    end
    
    find(:xpath, "//a[@data-value='all']").click
    page.should_not have_css(".dimmed")
  end
  
  scenario "The user can view the project details" do
    login_as(@al)
    visit organization_page(@kisko.id)
    click_link "Ongoing project"
    page.should have_content("Edit Project")
    page.should have_content("How is the project going?")
  end
  
  scenario "Comments can be posted" do
    login_as(@al)
    visit project_page(@ongoing.id)
    fill_in "status_text", :with => "Everything is fine and dandy."
    click_button "Post"
    page.should have_content("Comment saved")
    page.should have_content("Everything is fine and dandy.")
  end
  
  scenario "Comments are listed and paginated", :js => true do
    20.times do
      FactoryGirl.create(:status, { :project_id => @ongoing.id, :user_id => @al.id })
    end
    login_as(@al)
    visit project_page(@ongoing.id)
    page.should have_content("Activity")
    page.all(".activity").count.should == 10

    Capybara.default_wait_time = 10
    click_link "Show more"
    page.all(".activity").count.should == 20
    Capybara.default_wait_time = 5
  end
  
  scenario "User can edit a project", :js => true do
    login_as(@al)
    visit project_page(@ongoing.id)
    find(:css, "#top a.edit").click
    
    page.should have_content("Edit #{@ongoing.name}")
    
    fill_in "project_name", :with => "The End of The World!"
    fill_in "project_human_start", :with => "1 January 2012"
    fill_in "project_human_end", :with => "31 December 2012"
    
    find(:css, "label[for='project_state_on_hold']").click
    find(:css, "label[for='project_user_ids_#{@al.id}']").click
    click_button "Update Project"
    
    page.should have_content("Project was successfully updated.")
  end
  
  scenario "User can delete a project", :js => true do
    login_as(@al)
    visit project_edit_page(@ongoing.id)
    
    click_button "Destroy this project!"
    
    alert = page.driver.browser.switch_to.alert
    if alert.text == "Are you sure you want to destroy this project?"
      alert.accept
    else
      alert.dismiss
    end
    
    page.should have_content("Project was successfully deleted.")
  end
  
  scenario "Email notification (un)subscription", :js => true do
    login_as(@al)
    visit project_page(@ongoing.id)
    
    page.should have_css("input[value='Subscribe to notifications']")
    
    click_button "Subscribe to notifications"
    page.should have_css("input[value='Unsubscribe from notifications']")
    
    click_button "Unsubscribe from notifications"
    page.should have_css("input[value='Subscribe to notifications']")
  end
  
  scenario "Enable/disable guest access" do
    login_as(@al)
    visit project_page(@ongoing.id)
    click_button "Off"
    page.should have_css("input.copy_url")
    guest_url = find(:css, "input.copy_url").value
    guest_url.should match(URI::regexp(["http", "https"]))
    
    logout
    
    visit guest_url
    page.should have_content("[Guest access]")
    page.should have_no_xpath("//form")
    page.should have_no_xpath("//input")
    page.should have_no_content("Edit Project")
  end
end
