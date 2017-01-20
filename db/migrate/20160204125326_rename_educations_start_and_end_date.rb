class RenameEducationsStartAndEndDate < ActiveRecord::Migration
  def up
    rename_column :educations, :from_study_date, :start_date
    rename_column :educations, :to_study_date, :end_date
  end

  def down
    rename_column :educations, :start_date, :from_study_date
    rename_column :educations, :end_date, :to_study_date
  end
end
