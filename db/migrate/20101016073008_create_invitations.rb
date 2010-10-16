class CreateInvitations < ActiveRecord::Migration
  def self.up
    create_table :invitations do |t|
      t.integer :organization_id
      t.string :email
      t.string :token

      t.timestamps
    end
  end

  def self.down
    drop_table :invitations
  end
end
