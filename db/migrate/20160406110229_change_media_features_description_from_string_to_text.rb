class ChangeMediaFeaturesDescriptionFromStringToText < ActiveRecord::Migration
  def change
    remove_column :media_features, :description, :string
    add_column :media_features, :description, :text
  end
end
