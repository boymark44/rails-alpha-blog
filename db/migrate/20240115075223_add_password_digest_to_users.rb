class AddPasswordDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    # table :users, column_name :password_digest, format :string
    add_column :users, :password_digest, :string
  end
end
