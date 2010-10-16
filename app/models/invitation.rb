class Invitation < ActiveRecord::Base
  validates_presence_of :token
  validates_presence_of :organization_id
  after_create :send_notification
  belongs_to :organization
  validates :email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 254},
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  def send_notification
    Notifier.new_invitation(self).deliver
  end
  
end
