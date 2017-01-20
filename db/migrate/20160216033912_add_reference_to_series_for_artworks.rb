class AddReferenceToSeriesForArtworks < ActiveRecord::Migration
  def change
    add_reference :artworks, :series, index: true
  end
end
