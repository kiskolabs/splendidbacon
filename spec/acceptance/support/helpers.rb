module HelperMethods
  def login_as(resource, opts={})
    resource =  resource.is_a?(Symbol) ? Factory(resource, opts) : resource

    visit sign_in_page
    fill_in "Email", :with => resource.email
    fill_in "Password", :with => opts[:password] || resource.password
    click_button "Sign in"
    
    resource
  end
  
  def fill_in_sign_up_form(opts = {})
    fill_in "Email", :with => opts[:email]
    fill_in "Name", :with => opts[:name]
    fill_in "Password", :with => opts[:password]
    fill_in "user_password_confirmation", :with => opts[:password]
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
