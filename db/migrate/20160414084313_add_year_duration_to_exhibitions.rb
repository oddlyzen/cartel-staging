class AddYearDurationToExhibitions < ActiveRecord::Migration
  def change
    add_column :exhibitions, :start_year, :integer
    add_column :exhibitions, :end_year, :integer
  end
end
