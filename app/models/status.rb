class Status < ActiveRecord::Base
  default_scope order('id DESC')
  belongs_to :user
  belongs_to :project
  
  validates_presence_of :text
  validates_presence_of :source
  
end
