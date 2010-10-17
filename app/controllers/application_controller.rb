class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_navigation_for_devise_controllers

  protected

  def no_background!
    @no_background = true
  end

  def navigation(identifier)
    @navigation_id = identifier
  end

  def set_navigation_for_devise_controllers
    if controller_name == "registrations" && action_name == "edit"
      navigation :account
    end
  end
end
