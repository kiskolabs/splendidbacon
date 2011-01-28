class ZendeskAuthController < ApplicationController
  include Zendesk::RemoteAuthHelper

  before_filter :authenticate_user!, :except => [ :logout ]

  def authorize
    redirect_to zendesk_remote_auth_url(current_user)
  end

  def logout
    sign_out :user
    redirect_to root_path
  end
end
