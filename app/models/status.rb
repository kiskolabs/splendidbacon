class Status < ActiveRecord::Base
  default_scope order('id DESC')
  belongs_to :user
  belongs_to :project
  
  validates_presence_of :text
  validates_presence_of :source
  
  validates_uniqueness_of :text, :scope => [:project_id, :source, :link]
  
  def self.create_from_github_payload(json, project)
    payload = JSON.parse(json)
    
    if payload && payload["commits"].count > 0
      payload["commits"].map do |commit|
        user = User.where(:email => commit["author"]["email"]).first
        status = project.statuses.new(:link => commit["url"], :text => commit["message"], :source => "GitHub")
        status.user = user if user
        status.save
        status
      end
    end
  end
  
  def self.create_from_pivotal_tracker_payload(xml, project)
    activity = Nokogiri::XML(xml)
    event_type = activity.xpath("/activity/event_type").try(:text)
    if ["story_create", "story_update"].include? event_type
      status = project.statuses.build( :link => activity.xpath("/activity//story[1]/url").text, 
                                       :text => activity.xpath("/activity/description").text, 
                                       :source => "Pivotal Tracker" )
      status.save
      status
    end
  end
end
