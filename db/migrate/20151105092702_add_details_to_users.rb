class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :first_name, :string
    add_column :users, :initial, :string
    add_column :users, :last_name, :string
    add_column :users, :date_of_birth, :date
  end
end
