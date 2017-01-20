class AddVenueIdToExhibitions < ActiveRecord::Migration
  def change
    add_reference :exhibitions, :venue, index: true
  end
end
