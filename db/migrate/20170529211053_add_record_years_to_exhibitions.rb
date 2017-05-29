class AddRecordYearsToExhibitions < ActiveRecord::Migration
  def change
    add_column :exhibitions, :record_start_year, :integer
    add_column :exhibitions, :record_end_year, :integer
  end
end
