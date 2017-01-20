class RemoveEducationDataFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :from_study_month
    remove_column :users, :from_study_year
    remove_column :users, :to_study_month
    remove_column :users, :to_study_year
  end
end
