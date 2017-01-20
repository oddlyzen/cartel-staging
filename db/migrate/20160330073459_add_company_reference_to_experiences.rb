class AddCompanyReferenceToExperiences < ActiveRecord::Migration
  def change
    remove_column :experiences, :company, :string
    add_reference :experiences, :company, index: true
  end
end
