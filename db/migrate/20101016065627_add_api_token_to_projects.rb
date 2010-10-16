class AddApiTokenToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :api_token, :string
  end

  def self.down
    remove_column :projects, :api_token
  end
end
