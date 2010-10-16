class RenameProjectTokenToGuestToken < ActiveRecord::Migration
  def self.up
    rename_column :projects, :token, :guest_token
  end

  def self.down
    rename_column :projects, :guest_token, :token
  end
end
