class AddPdfUrlToBibliographyAndPublications < ActiveRecord::Migration
  def change
    add_column :bibliographies, :pdf_url, :string
    add_column :publications, :pdf_url, :string
  end
end
