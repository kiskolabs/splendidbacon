class AlterUserPasswordSalt < ActiveRecord::Migration
  # This is a legacy migration and it doesn't look like it's needed any more.
  # The column existance checks are here to make sure that wedon't break
  # anyone's migrations.

  def self.up
    if column_exists? :users, :password_salt
      change_column :users, :password_salt, :string, :null => true
    end
    if column_exists? :admins, :password_salt
      change_column :admins, :password_salt, :string, :null => true
    end
  end

  def self.down
    if column_exists? :users, :password_salt
      change_column :users, :password_salt, :string, :null => false
    end
    if column_exists? :admins, :password_salt
      change_column :admins, :password_salt, :string, :null => false
    end
  end
end