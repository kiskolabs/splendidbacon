class CreateStatuses < ActiveRecord::Migration
  def self.up
    create_table :statuses do |t|
      t.text :text
      t.string :link
      t.string :source
      t.references :user
      t.references :project

      t.timestamps
    end
  end

  def self.down
    drop_table :statuses
  end
end
