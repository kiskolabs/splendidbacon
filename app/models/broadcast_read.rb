class BroadcastRead < ActiveRecord::Base
  belongs_to :user
  belongs_to :broadcast
end
