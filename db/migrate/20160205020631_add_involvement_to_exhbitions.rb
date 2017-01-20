class AddInvolvementToExhbitions < ActiveRecord::Migration
  def change
    add_column :exhibitions, :involvement, :integer
  end
end
