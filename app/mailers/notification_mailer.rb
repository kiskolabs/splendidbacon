class NotificationMailer < ActionMailer::Base
  default :from => "notifications@splendidbacon.com"
  
  def new_comment(email, project_name, project_id, organization_name, organization_id, comment, comment_author)
    @project_url = project_url(project_id)
    @organization_url = organization_url(organization_id)
    @project_name = project_name
    @organization_name = organization_name
    @organization_id = organization_id
    @comment = comment
    @comment_author = comment_author
    
    mail( :to => email, 
          :subject => "[#{project_name}] New comment from #{comment_author}",
          :from =>  "notifications+#{@organization_name.parameterize}@splendidbacon.com")
  end
end
