class Broadcast < ActiveRecord::Base
  default_scope where("expiry >= ?", Time.now).order("expiry DESC")
  
  validates_datetime :expiry, :after => lambda { Time.now }, :on => :create, :after_message => "must be in the future"
  validates_presence_of :title
  validates_presence_of :text
  validates_presence_of :expiry
end
