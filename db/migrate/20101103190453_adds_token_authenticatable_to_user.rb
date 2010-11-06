class AddsTokenAuthenticatableToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.token_authenticatable
    end
    add_index :users, :email, :unique => true
  end

  def self.down
    change_table :users do |t|
      t.remove :authentication_token
    end
  end
end
