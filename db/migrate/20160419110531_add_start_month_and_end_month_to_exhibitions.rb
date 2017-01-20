class AddStartMonthAndEndMonthToExhibitions < ActiveRecord::Migration
  def change
    add_column :exhibitions, :start_month, :integer
    add_column :exhibitions, :end_month, :integer
  end
end
