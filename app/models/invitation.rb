class Invitation < ActiveRecord::Base
  validates_presence_of :token
  validates_presence_of :organization_id
  before_validation :generate_token
  after_create :send_notification
  belongs_to :organization
  
  validates :email, :presence => true, 
                    :length => {:minimum => 3, :maximum => 254},
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  validates_presence_of :token
  
  def send_notification
    Notifier.new_invitation(self).deliver
  end
  
  def generate_token
    self.token ||= SecureRandom.hex(8)
  end
end
