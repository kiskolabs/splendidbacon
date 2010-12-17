class CreateBroadcasts < ActiveRecord::Migration
  def self.up
    create_table :broadcasts do |t|
      t.string :title
      t.text :text
      t.datetime :expiry
      
      t.timestamps
    end
    
    add_index :broadcasts, :expiry
  end

  def self.down
    drop_table :broadcasts
  end
end
