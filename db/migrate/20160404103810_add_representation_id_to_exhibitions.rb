class AddRepresentationIdToExhibitions < ActiveRecord::Migration
  def change
    add_reference :exhibitions, :representation, index: true
  end
end
