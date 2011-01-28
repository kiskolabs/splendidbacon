class ZendeskAuthController < ApplicationController
  include Zendesk::RemoteAuthHelper

  before_filter :authenticate_user!, :except => [ :logout ]

  def authorize
    if in_demo?
      redirect_to root_path, :alert => "You can't login to the support site while in demo mode!"
    end
      redirect_to zendesk_remote_auth_url(current_user)
    end
  end

  def logout
    sign_out :user
    redirect_to root_path
  end
end
