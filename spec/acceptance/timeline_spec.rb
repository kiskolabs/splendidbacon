require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature "Timeline" do
  background do
    @al = User.create(:email => "al@kiskolabs.com", :name => "Al", :password => "12345678")
    @al.reset_authentication_token
    @al.save
    
    @kisko = @al.organizations.create(:name => "Kisko Labs")
    
    @ongoing = @kisko.projects.create(:name => "Ongoing project", :start => Date.today - 7.days, :end => 3.months.from_now, :state => :ongoing)
    @kisko.projects.create(:name => "On hold project", :start => Date.today - 7.days, :end => 3.months.from_now, :state => :on_hold)
    @ongoing.users << @al
    @ongoing.save
    
    @late = @kisko.projects.create(:name => "Late project", :start => Date.today - 7.days, :end => 3.months.ago, :state => :ongoing)
  end
  
  scenario "On time projects are in the timeline, late are not", :js => true do
    login_as(@al)
    visit timeline_page(@kisko.id)
    
    all("#tileline filterable_project") do |project|
      project.should have_content("Ongoing project")
    end

    all(".project_list li") do |project|
      project.should have_content("Late project")
    end
  end
end

