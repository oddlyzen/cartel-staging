class CreateBibliography < ActiveRecord::Migration
  def change
    create_table :bibliographies do |t|
      t.string :title, null: false
      t.date :date_of_publication
      t.string :publication_title
      t.string :publisher
      t.string :edition
      t.string :author
      t.string :page_number
      t.integer :source_type
      t.string :link
      t.references :user, index: true, foreign_key: true
    end
  end
end
