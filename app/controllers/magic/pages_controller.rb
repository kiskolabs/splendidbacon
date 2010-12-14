class Magic::PagesController < Magic::BaseController
  before_filter :stats, :only => [:dashboard, :update_stats]
  
  def dashboard
    navigation :dashboard
    
    @admins = Admin.all
  end
  
  def update_stats
    respond_to :js
  end
  
  private
  
  def stats
    @user_count = User.where("email NOT LIKE ?", "%@demoaccount.com").count
    @organization_count = Organization.where("name NOT LIKE ?", "Big Company").where("name NOT LIKE ?", "Freelancing").count
    @project_count = Project.where("name NOT LIKE ?", "Agi Project").where("name NOT LIKE ?", "Cash Cow").where("name NOT LIKE ?", "Doomed").count
    @demo_user_count = User.where("email LIKE ?", "%@demoaccount.com").count / 5
  end
end
