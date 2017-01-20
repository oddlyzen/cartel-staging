class ChangeUserDataType < ActiveRecord::Migration
  def self.up
    change_column :users, :residency_status, 'integer USING CAST("residency_status" AS integer)'
    change_column :users, :based_state, 'integer USING CAST("based_state" AS integer)'
  end

  def self.down
    change_column :users, :residency_status, :string
    change_column :users, :based_state, :string
  end
end
