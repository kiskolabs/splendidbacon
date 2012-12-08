require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Account Creation" do
  scenario "Sign up" do
    visit sign_up_page
    fill_in_sign_up_form(:email => "joe@doe.com", :name => "John Doe", :password => "12345678")
    click_button "Sign up"
    
    page.should have_content("Your account was successfully created. Welcome to Splendid Bacon")
  end
  
  scenario "Creating a demo account" do
    visit "/"
    click_link "Try the Demo"
    page.should have_content("You are currently using the demo mode.")
    page.should have_content("Dashboard")
    page.should have_content("Agi Project")
    page.should have_content("Cash Cow")
    page.should have_content("Doomed")
  end
  
  scenario "First selecting demo account and then creating real one" do
    visit "/"
    click_link "Try the Demo"
    click_link "Sign up here."
    fill_in_sign_up_form(:email => "joe@doe.com", :name => "John Doe", :password => "12345678")
    click_button "Sign up"
    
    page.should have_content("Your account was successfully created. Welcome to Splendid Bacon")
  end
end
