class Magic::BroadcastsController < ApplicationController
  def create
    @broadcast = Broadcast.create(params[:broadcast])
    redirect_to magic_root_path
  end
  
  def destroy
    @broadcast = Broadcast.find(params[:id])
    @broadcast.destroy
    respond_to :js
  end
end
