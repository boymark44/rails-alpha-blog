class AddAdminToUsers < ActiveRecord::Migration[7.1]
  def change
    # add a new column in users table called "admin" with a boolean datatype and default value of false
    add_column :users, :admin, :boolean, default: false 
  end
end
