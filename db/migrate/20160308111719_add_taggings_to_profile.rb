class AddTaggingsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :medium_ids, :integer, array: true, default: []
    add_index :profiles, :medium_ids, using: :gin

    add_column :profiles, :subject_ids, :integer, array: true, default: []
    add_index :profiles, :subject_ids, using: :gin

    add_column :profiles, :language_ids, :integer, array: true, default: []
    add_index :profiles, :language_ids, using: :gin

    add_column :profiles, :specialisation_ids, :integer, array: true, default: []
    add_index :profiles, :specialisation_ids, using: :gin

    add_column :profiles, :interest_ids, :integer, array: true, default: []
    add_index :profiles, :interest_ids, using: :gin

    add_column :profiles, :skill_ids, :integer, array: true, default: []
    add_index :profiles, :skill_ids, using: :gin

    add_column :profiles, :service_ids, :integer, array: true, default: []
    add_index :profiles, :service_ids, using: :gin
  end
end
