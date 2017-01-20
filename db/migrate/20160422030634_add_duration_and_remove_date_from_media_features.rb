class AddDurationAndRemoveDateFromMediaFeatures < ActiveRecord::Migration
  def change
    add_column :media_features, :month, :integer
    add_column :media_features, :year, :integer

    remove_column :media_features, :date, :date
  end
end
