class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :project_id
    end
    
    add_index :notifications, [:user_id, :project_id], :unique => true
    add_index :notifications, :project_id
    add_index :notifications, :user_id
  end

  def self.down
    drop_table :notifications
  end
end
