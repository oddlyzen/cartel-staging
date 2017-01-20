class AddStartDateAndEndDateToExperience < ActiveRecord::Migration
  def change
    rename_column :experiences, :date, :start_date
    add_column :experiences, :end_date, :date
  end
end
