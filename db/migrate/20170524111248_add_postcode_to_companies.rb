class AddPostcodeToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :postcode, :string
  end
end
