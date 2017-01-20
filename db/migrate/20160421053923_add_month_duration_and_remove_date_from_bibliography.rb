class AddMonthDurationAndRemoveDateFromBibliography < ActiveRecord::Migration
  def change
    rename_column :bibliographies, :start_year, :month
    rename_column :bibliographies, :end_year, :year

    remove_column :bibliographies, :date_of_publication, :date
  end
end
