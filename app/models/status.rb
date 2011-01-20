class Status < ActiveRecord::Base
  default_scope order('id DESC')
  belongs_to :user
  belongs_to :project
  
  validates_presence_of :text
  validates_presence_of :source
  
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
end
