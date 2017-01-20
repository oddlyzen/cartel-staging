class AddMediaAndSubjectTagsToArtworks < ActiveRecord::Migration
  def change
    add_column :artworks, :subjects_tags, :text, array: true, default: []
    add_column :artworks, :media_tags, :text, array: true, default: []
    add_column :artworks, :for_sale, :boolean, default: false
    add_column :artworks, :published_date, :date

    add_index :artworks, :media_tags, using: :gin
    add_index :artworks, :subjects_tags, using: :gin
  end
end
