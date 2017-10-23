class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :url
      t.string :title
      t.string :artwork_id

      t.timestamps null: false
    end
  end
end
