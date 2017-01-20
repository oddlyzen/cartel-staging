class AddMediaTagsIdToArtworks < ActiveRecord::Migration
  def change
    add_column :artworks, :medium_ids, :integer, array: true, default: []
    add_index :artworks, :medium_ids, using: :gin

    add_column :artworks, :subject_ids, :integer, array: true, default: []
    add_index :artworks, :subject_ids, using: :gin
  end
end
