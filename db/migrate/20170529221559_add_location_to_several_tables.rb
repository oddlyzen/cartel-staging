class AddLocationToSeveralTables < ActiveRecord::Migration
  def change
    add_column :exhibitions, :location, :string
    add_column :experiences, :location, :string
    add_column :educations, :location, :string
    add_column :residencies, :location, :string
    add_column :bibliographies, :location, :string
    add_column :publications, :location, :string
  end
end
