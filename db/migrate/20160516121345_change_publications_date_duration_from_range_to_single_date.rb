class ChangePublicationsDateDurationFromRangeToSingleDate < ActiveRecord::Migration
  def change
    remove_column :publications, :start_year, :integer
    remove_column :publications, :start_month, :integer
    remove_column :publications, :end_year, :integer
    remove_column :publications, :end_month, :integer
    add_column :publications, :year, :integer
    add_column :publications, :month, :integer
    add_column :publications, :day, :integer
  end
end
