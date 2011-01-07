class UsersController < ApplicationController
  respond_to :js
  
  def reset_authentication_token
    current_user.reset_authentication_token
    current_user.save
  end
end
