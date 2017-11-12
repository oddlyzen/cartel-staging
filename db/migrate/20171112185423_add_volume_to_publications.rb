class AddVolumeToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :volume, :string
    add_column :publications, :review_of, :string
  end
end
