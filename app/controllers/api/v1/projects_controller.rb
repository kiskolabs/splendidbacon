class Api::V1::ProjectsController < Api::BaseController
  before_filter :current_project, :only => [:github, :pivotal_tracker]
  
  def github
    payload = JSON.parse params["payload"]
    if payload && payload["commits"].count > 0
      payload["commits"].each do |commit|
        user = User.where(:email => commit["author"]["email"]).first
        status = @project.statuses.new(:link => commit["url"], :text => commit["message"], :source => "GitHub")
        status.user = user if user
        status.save
      end
    end
    head 200
  end

  def pivotal_tracker
    activity = Nokogiri::XML(request.body.read)
    event_type = activity.xpath("/activity/event_type").try(:text)
    if ["story_create", "story_update"].include? event_type
      status = @project.statuses.build(:link => activity.xpath("/activity//story[1]/url").text, 
                                       :text => activity.xpath("/activity/description").text, 
                                       :source => "Pivotal Tracker")
      status.save
    end
    head 200
  end
  
  private
  
  def current_project
    unless @project = Project.where(:id => params[:id], :api_token => params[:token]).first
      raise ActiveRecord::RecordNotFound
    end
  end
end
