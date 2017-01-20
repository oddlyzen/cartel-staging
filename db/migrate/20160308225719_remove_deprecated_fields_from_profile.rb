class RemoveDeprecatedFieldsFromProfile < ActiveRecord::Migration
  def up
    remove_index :profiles, name: :index_profiles_on_languages
    remove_index :profiles, name: :index_profiles_on_skills
    remove_index :profiles, name: :index_profiles_on_themes
    remove_index :profiles, name: :index_profiles_on_media
    remove_index :profiles, name: :index_profiles_on_specialisations
    remove_index :profiles, name: :index_profiles_on_interests
    remove_index :profiles, name: :index_profiles_on_services

    remove_column :profiles, :languages
    remove_column :profiles, :skills
    remove_column :profiles, :themes
    remove_column :profiles, :media
    remove_column :profiles, :specialisations
    remove_column :profiles, :interests
    remove_column :profiles, :services
  end

  def down
    add_column :profiles, :languages, :text, array: true, default: []
    add_column :profiles, :skills, :text, array: true, default: []
    add_column :profiles, :themes, :text, array: true, default: []
    add_column :profiles, :media, :text, array: true, default: []
    add_column :profiles, :specialisations, :text, array: true, default: []
    add_column :profiles, :interests, :text, array: true, default: []
    add_column :profiles, :services, :text, array: true, default: []

    add_index :profiles, :languages, using: :gin
    add_index :profiles, :skills, using: :gin
    add_index :profiles, :themes, using: :gin
    add_index :profiles, :media, using: :gin
    add_index :profiles, :specialisations, using: :gin
    add_index :profiles, :interests, using: :gin
    add_index :profiles, :services, using: :gin
  end
end

