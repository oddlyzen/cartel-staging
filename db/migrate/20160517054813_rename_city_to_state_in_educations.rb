class RenameCityToStateInEducations < ActiveRecord::Migration
  def change
    rename_column :educations, :city, :state
  end
end
