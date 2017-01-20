class RemoveLanguageIdsFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :language_ids, array: true, default: [], index: { using: :gin }
  end
end
