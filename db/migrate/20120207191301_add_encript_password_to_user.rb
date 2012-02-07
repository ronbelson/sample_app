class AddEncriptPasswordToUser < ActiveRecord::Migration


  def self.up
    add_column :users, :encripted_password, :string
  end

  def self.down
    remove_column :users, :encripted_password
  end

end
