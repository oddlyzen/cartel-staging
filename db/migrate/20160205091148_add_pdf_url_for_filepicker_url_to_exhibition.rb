class AddPdfUrlForFilepickerUrlToExhibition < ActiveRecord::Migration
  def change
    add_column :exhibitions, :pdf_url, :string
  end
end
