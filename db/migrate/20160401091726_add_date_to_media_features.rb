class AddDateToMediaFeatures < ActiveRecord::Migration
  def change
    add_column :media_features, :date, :date
  end
end
