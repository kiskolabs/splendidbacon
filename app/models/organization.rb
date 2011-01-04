class Organization < ActiveRecord::Base
  has_many :projects, :dependent => :destroy
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :invitations, :dependent => :destroy
  validates_presence_of :name
  
  scope :real, where("name NOT LIKE ?", "Big Company").where("name NOT LIKE ?", "Freelancing")
end
