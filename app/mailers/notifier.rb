class Notifier < ActionMailer::Base
  default :from => "no-reply@splendidbacon.com"
  
  def new_invitation(invitation)
    @invitation = invitation
    mail(:to => "#{invitation.email}", :subject => "[Splendid Bacon] New invitation")
  end
  
end
