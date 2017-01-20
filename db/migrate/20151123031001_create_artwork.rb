class CreateArtwork < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :image_url
      t.string :title
      t.integer :height
      t.integer :width
      t.integer :length
      t.integer :unit
      t.integer :year
      t.string :art_type
      t.string :description
      t.string :subject_themes
      t.integer :user_id
    end
  end
end
