class AddEducationDataToEducations < ActiveRecord::Migration
  def change
    add_column :educations, :from_study_month, :integer
    add_column :educations, :from_study_year, :integer
    add_column :educations, :to_study_month, :integer
    add_column :educations, :to_study_year, :integer
    add_column :educations, :institution, :string
    add_column :educations, :education_level, :string
    add_column :educations, :education_grade, :string
    add_column :educations, :field_of_study, :string
    add_column :educations, :education_description, :string
  end
end
