class CreateBroadcastReads < ActiveRecord::Migration
  def self.up
    create_table(:broadcast_reads, :id => false) do |t|
      t.references :user
      t.references :broadcast
    end
    
    add_index :broadcast_reads, [:user_id, :broadcast_id], :unique => true
  end

  def self.down
    drop_table :broadcast_reads
  end
end
