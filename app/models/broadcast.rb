class Broadcast < ActiveRecord::Base
  has_many :broadcast_reads, :dependent => :delete_all
  has_many :users, :through => :broadcast_reads
  
  default_scope where("expiry >= ?", Time.now).order("expiry DESC")
  
  validates_datetime :expiry, :after => lambda { Time.now }, :on => :create, :after_message => "must be in the future"
  validates_presence_of :title
  validates_presence_of :text
  validates_presence_of :expiry
end
