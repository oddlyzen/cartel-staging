class AddVolumeToBibliographies < ActiveRecord::Migration
  def change
    add_column :bibliographies, :volume, :string
    add_column :bibliographies, :review_of, :string
  end
end
