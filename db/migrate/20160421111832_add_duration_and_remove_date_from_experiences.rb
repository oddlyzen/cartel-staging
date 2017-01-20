class AddDurationAndRemoveDateFromExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :start_month, :integer
    add_column :experiences, :start_year, :integer
    add_column :experiences, :end_month, :integer
    add_column :experiences, :end_year, :integer

    remove_column :experiences, :start_date, :date
    remove_column :experiences, :end_date, :date
  end
end
