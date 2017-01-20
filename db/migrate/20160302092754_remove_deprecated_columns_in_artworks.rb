class RemoveDeprecatedColumnsInArtworks < ActiveRecord::Migration
  def up
    remove_index :artworks, name: :index_artworks_on_media_tags
    remove_index :artworks, name: :index_artworks_on_subjects_tags

    remove_column :artworks, :subject_themes
    remove_column :artworks, :subjects_tags
    remove_column :artworks, :media_tags
  end

  def down
    add_column :artworks, :subject_themes, :string

    add_column :artworks, :subjects_tags, :text, array: true, default: []
    add_column :artworks, :media_tags, :text, array: true, default: []

    add_index :artworks, :media_tags, using: :gin
    add_index :artworks, :subjects_tags, using: :gin
  end
end
