class AddOtherStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :other_status, :string
  end
end
