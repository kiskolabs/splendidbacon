class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:reset_authentication_token]

  def sign_out_and_up
    sign_out :user
    redirect_to new_user_registration_path
  end
  
  def reset_authentication_token
    current_user.reset_authentication_token
    current_user.save
    redirect_to edit_user_registration_path, :notice => "Your API token has been reset"
  end
end
