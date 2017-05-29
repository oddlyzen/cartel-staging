class AddLocationToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :location, :string
  end
end
