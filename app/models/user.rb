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
    Status.create!(:text => "Customer asked for the Layout", :link => nil, :source => "Comment", :user_id => u[1].id, :project_id => p.id)
    Status.create!(:text => "Ok, Delivering it during today", :link => nil, :source => "Comment", :user_id => u[0].id, :project_id => p.id)
    p=Project.create!(:name => "Doomed", :start => "2010-09-01", :end => "2011-12-17", :active => false, :organization_id => o1.id)
    Participation.create!(:user_id => u[0].id, :project_id => p.id)
    Participation.create!(:user_id => u[1].id, :project_id => p.id)
    Participation.create!(:user_id => u[2].id, :project_id => p.id)
    Participation.create!(:user_id => u[3].id, :project_id => p.id)
    Status.create!(:text => "Dont need to spell out the dependency", :link => "http://github.com/rails/rails/commit/b227a9a94838aebb8fa6b9b6f69f100d7e516a0c", :source => "Github", :user_id => u[3].id, :project_id => p.id)
    Status.create!(:text => "Ok, David that's enough", :link => nil, :source => "Comment", :user_id => u[2].id, :project_id => p.id)
    Status.create!(:text => "Come on this project is doomed!", :link => nil, :source => "Comment", :user_id => u[3].id, :project_id => p.id)
    p=Project.create!(:name => "Cash Cow", :start => "2010-10-17", :end => "2011-03-01", :active => true, :organization_id => o1.id)
    Participation.create!(:user_id => u[1].id, :project_id => p.id)
    Participation.create!(:user_id => u[2].id, :project_id => p.id)
    Participation.create!(:user_id => u[3].id, :project_id => p.id)
    Status.create!(:text => "Project is going smooth!", :link => nil, :source => "Comment", :user_id => u[2].id, :project_id => p.id)
    Status.create!(:text => "No need for parenthesis here", :link => "http://github.com/rails/rails/commit/67df21f8954073ddc7f3409ec618c953f97cb412", :source => "Github", :user_id => u[1].id, :project_id => p.id)
    Status.create!(:text => "There's some pizza in the kitchen", :link => nil, :source => "Comment", :user_id => u[1].id, :project_id => p.id)
    Status.create!(:text => "Too bad I'm not at the office", :link => nil, :source => "Comment", :user_id => u[3].id, :project_id => p.id)
    p=Project.create!(:name => "Portal Project", :start => "2010-09-01", :end => "2011-01-01", :active => true, :organization_id => o2.id)
    Participation.create!(:user_id => self.id, :project_id => p.id)
    p=Project.create!(:name => "Personal Homepage", :start => "2010-10-01", :end => "2010-12-15", :active => true, :organization_id => o2.id)
    Status.create!(:text => "Add task foo:install (where foo is plugin) as a shortcutinstall:migrations and foo:install:assets", :link => "http://github.com/rails/rails/commit/43215de208a6feabdbc5f4ec29551beef4f89885", :source => "Github", :user_id => self.id, :project_id => p.id)
    Status.create!(:text => "Comment internal railties tasks.", :link => "http://github.com/rails/rails/commit/c7aea81a39e130bfddd26537dea5f3626e2a009e", :source => "Github", :user_id => self.id, :project_id => p.id)
    Status.create!(:text => "Update documentation for new tasks", :link => "http://github.com/rails/rails/commit/a2c52f100446ab328cbde0e505216a99c602bc57", :source => "Github", :user_id => self.id, :project_id => p.id)
    Participation.create!(:user_id => self.id, :project_id => p.id)
    p=Project.create!(:name => "Garage Project", :start => "2010-10-15", :end => "2010-11-30", :active => true, :organization_id => o2.id)
    Participation.create!(:user_id => self.id, :project_id => p.id)
    Status.create!(:text => "Remember to use jQuery this time", :link => nil, :source => "Comment", :user_id => self.id, :project_id => p.id)
  end
end
