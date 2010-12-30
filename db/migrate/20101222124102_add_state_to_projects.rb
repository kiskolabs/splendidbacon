class AddStateToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :state, :string

    Project.reset_column_information
    Project.where(:active => true).update_all({:state => :ongoing})
    Project.where(:active => false).update_all({:state => :on_hold})
  end

  def self.down
    remove_column :projects, :state
  end
end
