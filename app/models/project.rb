class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many :statuses
  
  validates_presence_of :start
  validates_presence_of :end
  validates_presence_of :name
  validates_date :end, :on_or_after => :start, :on_or_after_message => "cannot be before the start date."
end
