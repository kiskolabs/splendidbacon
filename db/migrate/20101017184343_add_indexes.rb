class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :invitations, :organization_id
    add_index :invitations, :token

    add_index :memberships, [:user_id, :organization_id]

    add_index :participations, [:user_id, :project_id]

    add_index :projects, :guest_token
    add_index :projects, :organization_id
    add_index :projects, :api_token

    add_index :statuses, :project_id
  end

  def self.down
    remove_index :invitations, :organization_id
    remove_index :invitations, :token

    remove_index :memberships, [:user_id, :organization_id]

    remove_index :participations, [:user_id, :project_id]

    remove_index :projects, :guest_token
    remove_index :projects, :organization_id
    remove_index :projects, :api_token

    remove_index :statuses, :project_id
  end
end
