class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def no_background!
    @no_background = true
  end
end
