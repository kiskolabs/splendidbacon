class Project < ActiveRecord::Base
  STATES = {:ongoing => "Ongoing", 
            :on_hold => "On Hold", 
            :completed => "Completed"}

  has_many :participations, :dependent => :destroy
  has_many :users, :through => :participations
  belongs_to :organization
  has_many :statuses, :dependent => :destroy
  
  before_create :generate_api_token
  
  validates_presence_of :start
  validates_presence_of :end
  validates_presence_of :name
  validates_date :end, :on_or_after => :start, :on_or_after_message => "cannot be before the start date."
  validates_presence_of :state
  validates_inclusion_of :state, :in => STATES.keys, :allow_blank => true
  
  scope :current, where(:state => [:ongoing, :on_hold])
  scope :completed, where(:state => :completed)

  def last_activity
    status = self.statuses.select(:created_at).first
    status.nil? ? self.start.to_time_in_current_zone : status.created_at
  end
  
  def regenerate_api_token
    self.generate_api_token
    self.save
  end
  
  def toggle_guest_access
    self.guest_token = if self.guest_token.present?
      nil
    else
      SecureRandom.hex 16
    end
    self.save
  end
  
  def human_start
    self.start.present? ? self.start.strftime("%d %B %Y") : Date.today.strftime("%d %B %Y")
  end
  
  def human_start=(string)
    self.start = Kronic.parse(string)
  end
  
  def human_end
    self.end.present? ? self.end.strftime("%d %B %Y") : Date.today.strftime("%d %B %Y")
  end
  
  def human_end=(string)
    self.end = Kronic.parse(string)
  end

  def state
    super.try(:to_sym)
  end

  def state_name
    STATES[state]
  end

  def active?
    state == :ongoing
  end

  def completed?
    state == :completed
  end
  
  protected
  
  def generate_api_token
    self.api_token = SecureRandom.hex 32
  end
end
