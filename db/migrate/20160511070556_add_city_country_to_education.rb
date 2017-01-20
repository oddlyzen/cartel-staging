class AddCityCountryToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :city, :string
    add_column :educations, :country, :string
  end
end
