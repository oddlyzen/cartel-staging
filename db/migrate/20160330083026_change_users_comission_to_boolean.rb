class ChangeUsersComissionToBoolean < ActiveRecord::Migration
  def change
    remove_column :users, :commission, :string
    add_column :users, :commission, :boolean
  end
end
