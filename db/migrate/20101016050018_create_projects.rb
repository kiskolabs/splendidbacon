class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.date :start
      t.date :end
      t.boolean :active
      t.string :name
      t.string :token
    end
  end

  def self.down
    drop_table :projects
  end
end
