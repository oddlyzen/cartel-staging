class AddBibliographyDataToBibliography < ActiveRecord::Migration
  def change
  	add_column :bibliographies, :participation, :string
  	add_column :bibliographies, :publication_city, :string
  	add_column :bibliographies, :publication_country, :string
  	add_column :bibliographies, :editor, :string
  	add_column :bibliographies, :issue, :string
  end
end
