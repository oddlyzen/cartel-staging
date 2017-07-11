class AddOtherInstitutionToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :other_institution, :string
  end
end
