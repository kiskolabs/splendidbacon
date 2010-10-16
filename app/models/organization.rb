class Organization < ActiveRecord::Base
  has_many :projects, :dependent => :destroy
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :invitations, :dependent => :destroy
  validates_presence_of :name
end
