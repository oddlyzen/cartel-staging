class AddGradeAndVenueToUsers < ActiveRecord::Migration
  def change
    add_column :users, :grade, :integer
    add_column :users, :gallery_museum, :string
  end
end
