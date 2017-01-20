class AddRepresentationToExhibitions < ActiveRecord::Migration
  def change
    add_column :exhibitions, :representation, :string
  end
end
