class BroadcastReadsController < ApplicationController
  def create
    broadcast = Broadcast.find(params[:broadcast_id])
    broadcast_read = current_user.broadcast_reads.create(:broadcast => broadcast)
    head :created
  end
end
