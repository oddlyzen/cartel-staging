class ChangeBasedStateToStringFromIntegerEnum < ActiveRecord::Migration
  def up
    remove_column :users, :based_state, :integer
    add_column :users, :based_state, :string
  end

  def down
    remove_column :users, :based_state, :string
    add_column :users, :based_state, :integer
  end
end
