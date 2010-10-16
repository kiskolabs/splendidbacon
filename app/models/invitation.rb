class Invitation < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :token
  validates_presence_of :organization_id
  after_create :send_notification
  belongs_to :organization
  
  def send_notification
    Notifier.new_invitation(self).deliver
  end
  
end
