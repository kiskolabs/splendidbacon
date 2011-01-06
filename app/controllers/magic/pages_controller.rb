class Magic::PagesController < Magic::BaseController
  before_filter :stats, :only => [:dashboard, :update_stats]
  
  def dashboard
    navigation :dashboard
    
    @admins = Admin.all
    @broadcast = Broadcast.new
    @broadcasts = Broadcast.all
  end
  
  def update_stats
    respond_to :js
  end
  
  private
  
  def stats
    @user_count = User.real.count
    @organization_count = Organization.real.count
    @project_count = Project.real.count
    @demo_user_count = User.demo.count / 5
  end
end
