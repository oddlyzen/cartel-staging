class RemoveStartDateAndEndDateFromExhibitions < ActiveRecord::Migration
  def change
    remove_column :exhibitions, :start_date, :date
    remove_column :exhibitions, :end_date, :date
  end
end
