class ChangeUserEducationNewData < ActiveRecord::Migration
  def change
  	remove_column :educations, :from_study_month, :integer
  	remove_column :educations, :from_study_year, :integer
  	remove_column :educations, :to_study_month, :integer
  	remove_column :educations, :to_study_year, :integer
  	add_column :educations, :from_study_date, :date
  	add_column :educations, :to_study_date, :date
  end
end
