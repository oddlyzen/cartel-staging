class AddInterestsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :interests, :text, array: true, default: [] 
    add_index :profiles, :interests, using: :gin
    add_column :profiles, :services, :text, array: true, default: [] 
    add_index :profiles, :services, using: :gin
  end
end
