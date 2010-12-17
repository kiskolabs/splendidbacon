class BroadcastRead < ActiveRecord::Base
  belongs_to :user
  belongs_to :broadcast
  
  scope :not_read_by, lambda { |user| }
end
