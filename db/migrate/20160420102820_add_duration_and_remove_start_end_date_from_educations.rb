class AddDurationAndRemoveStartEndDateFromEducations < ActiveRecord::Migration
  def change
    add_column :educations, :start_month, :integer
    add_column :educations, :end_month, :integer
    add_column :educations, :start_year, :integer
    add_column :educations, :end_year, :integer

    remove_column :educations, :start_date, :date
    remove_column :educations, :end_date, :date
  end
end
