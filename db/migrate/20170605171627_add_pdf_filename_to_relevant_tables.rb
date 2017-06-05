class AddPdfFilenameToRelevantTables < ActiveRecord::Migration
  def change
    add_column :exhibitions, :pdf_filename, :string
    add_column :bibliographies, :pdf_filename, :string
    add_column :publications, :pdf_filename, :string
  end
end
