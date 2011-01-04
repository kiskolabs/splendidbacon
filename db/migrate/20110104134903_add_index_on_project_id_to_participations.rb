class AddIndexOnProjectIdToParticipations < ActiveRecord::Migration
  def self.up
    add_index :participations, :project_id
  end

  def self.down
    remove_index :participations, :project_id
  end
end
