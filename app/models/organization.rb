class Organization < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  has_many :projects, :dependent => :destroy
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :invitations, :dependent => :destroy
  validates_presence_of :name
  
  scope :real, where("name NOT LIKE ?", "Big Company").where("name NOT LIKE ?", "Freelancing")
  
  def as_json(opts={})
    hash = super(opts)
    hash["organization"]["url"] = url
    hash
  end
  
  def url
    organization_url({ :host => Rails.application.config.action_mailer.default_url_options[:host],
                       :protocol => Rails.application.config.action_mailer.default_url_options[:protocol],
                       :id => id })
  end
  
  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end
end
