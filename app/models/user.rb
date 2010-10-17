class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  
  validates_presence_of :name
  
  has_many :memberships
  has_many :organizations, :through => :memberships

  has_many :participations
  has_many :projects, :through => :participations
  
  def gravatar_url(size = 64)
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=#{size.to_i}&d=identicon"
  end

  def create_demo_data
    users = ["Fred Astair", "Rick Rack", "Nemo Relic", "David Handsome"]
    
    o1=Organization.create!(:name => "Big Company")
    Membership.create!(:organization_id => o1.id, :user_id => self.id)

    o2=Organization.create!(:name => "Freelancing")
    Membership.create!(:organization_id => o2.id, :user_id => self.id)
    
    u = []
    users.each do |user|
      pass = SecureRandom.hex(8)
      u += [User.create!(:name => user, :email => SecureRandom.hex(8) + "@demoaccount.com", :password => pass, :password_confirmation => pass)]
      Membership.create!(:organization_id => o1.id, :user_id => u.last.id)
    end
    
    p=Project.create!(:name => "Agi Project", :start => "2010-10-01", :end => "2010-11-17", :active => true, :organization_id => o1.id)
    Participation.create!(:user_id => u[0].id, :project_id => p.id)
    Participation.create!(:user_id => u[1].id, :project_id => p.id)
    p=Project.create!(:name => "Agi Project", :start => "2010-09-01", :end => "2011-12-17", :active => false, :organization_id => o1.id)
    Participation.create!(:user_id => u[0].id, :project_id => p.id)
    Participation.create!(:user_id => u[1].id, :project_id => p.id)
    Participation.create!(:user_id => u[2].id, :project_id => p.id)
    Participation.create!(:user_id => u[3].id, :project_id => p.id)
    p=Project.create!(:name => "Cash Cow", :start => "2010-10-17", :end => "2011-03-01", :active => true, :organization_id => o1.id)
    Participation.create!(:user_id => u[1].id, :project_id => p.id)
    Participation.create!(:user_id => u[2].id, :project_id => p.id)
    Participation.create!(:user_id => u[3].id, :project_id => p.id)
    
    p=Project.create!(:name => "Portal Project", :start => "2010-09-01", :end => "2011-01-01", :active => true, :organization_id => o2.id)
    Participation.create!(:user_id => self.id, :project_id => p.id)
    p=Project.create!(:name => "Personal Homepage", :start => "2010-10-01", :end => "2010-12-15", :active => true, :organization_id => o2.id)
    Participation.create!(:user_id => self.id, :project_id => p.id)
    p=Project.create!(:name => "Garage Project", :start => "2010-10-15", :end => "2010-11-30", :active => true, :organization_id => o2.id)
    Participation.create!(:user_id => self.id, :project_id => p.id)
  end
end
