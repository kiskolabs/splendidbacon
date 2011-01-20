class AddNewsletterOptionToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :newsletter, :boolean, :default => true
  end

  def self.down
    remove_column :users, :newsletter
  end
end
