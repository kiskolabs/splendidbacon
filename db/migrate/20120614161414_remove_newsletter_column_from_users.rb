class RemoveNewsletterColumnFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :newsletter
  end

  def down
    add_column :users, :newsletter, :boolean
  end
end
