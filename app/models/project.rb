class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
  has_many :statuses
  
  before_create :generate_api_token
  
  validates_presence_of :start
  validates_presence_of :end
  validates_presence_of :name
  validates_date :end, :on_or_after => :start, :on_or_after_message => "cannot be before the start date."
  
  def last_activity
    self.statuses.order(:created_at).select(:created_at).last.created_at
  end
  
  def regenerate_api_token
    self.generate_api_token
    self.save
  end
  
  protected
  
  def generate_api_token
    self.api_token = SecureRandom.hex 32
  end
end
