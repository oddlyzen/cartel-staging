class AddDurationAndRemoveDateFromResidencies < ActiveRecord::Migration
  def change
    add_column :residencies, :start_month, :integer
    add_column :residencies, :start_year, :integer
    add_column :residencies, :end_month, :integer
    add_column :residencies, :end_year, :integer

    remove_column :residencies, :start_date, :date
    remove_column :residencies, :end_date, :date
  end
end
