class AddDetailsToArtworks < ActiveRecord::Migration
  def change
    add_column :artworks, :country, :string
    add_column :artworks, :city, :string
    add_column :artworks, :notes, :text
    add_column :artworks, :artist_inventory, :integer
    add_column :artworks, :gallery_inventory, :integer
    add_column :artworks, :private_collection, :text
    add_column :artworks, :public_collection, :text
    add_column :artworks, :edition, :integer
    add_column :artworks, :edition_of, :integer
    add_column :artworks, :signature, :string
    add_column :artworks, :signature_location, :string
    add_column :artworks, :signed_dated, :boolean, default: false
    add_column :artworks, :acknowledgement, :boolean, default: false
  end
end
