require "json"

class NotificationJob
  @queue = :low
  
  def self.perform(emails, project, organization, status, author)
    @project = JSON.parse(project)
    @organization = JSON.parse(organization)
    @status = JSON.parse(status)
    @author = author
    
    emails.each do |email|
      NotificationMailer.new_comment(email, @project["project"]["name"], @project["project"]["id"].to_i, @organization["organization"]["name"], @organization["organization"]["id"].to_i, @status["status"]["text"], @author).deliver
    end
  end
end