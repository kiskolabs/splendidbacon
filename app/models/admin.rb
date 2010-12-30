class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :recoverable, :registerable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def gravatar_url(size = 64)
    "https://secure.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?s=#{size.to_i}&d=#{CGI::escape("https://splendidbacon.com/images/default.png")}"
  end
end
