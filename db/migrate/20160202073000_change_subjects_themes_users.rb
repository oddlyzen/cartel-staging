class ChangeSubjectsThemesUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :subjects_themes
    add_column :users, :subjects_themes, :text, array: true, default: []
    add_index :users, :subjects_themes, using: :gin
  end

  def self.down
    add_column :users, :subjects_themes, :string
  end
end
