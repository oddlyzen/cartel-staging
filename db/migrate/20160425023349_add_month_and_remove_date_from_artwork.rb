class AddMonthAndRemoveDateFromArtwork < ActiveRecord::Migration
  def change
    add_column :artworks, :month, :integer

    remove_column :artworks, :published_date, :date
  end
end
