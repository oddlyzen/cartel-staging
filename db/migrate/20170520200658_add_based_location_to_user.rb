class AddBasedLocationToUser < ActiveRecord::Migration
  def change
    add_column :users, :based_location, :string
  end
end
