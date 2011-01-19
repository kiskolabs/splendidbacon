class Status < ActiveRecord::Base
  default_scope order('id DESC')
  belongs_to :user
  belongs_to :project
  
  validates_presence_of :text
  validates_presence_of :source
  
  after_create :enqueue_notification_emails, :if => proc { |s| s.source == "Comment" }
  
  private
  
  def enqueue_notification_emails
    project = self.project
    emails = project.subscribers.map { |n| n.email }
    organization = project.organization
    Resque.enqueue(NotificationJob, emails, project.to_json(:include => []), organization.to_json, self.to_json, self.user.name)
  end
end
