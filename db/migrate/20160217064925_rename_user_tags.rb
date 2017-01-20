class RenameUserTags < ActiveRecord::Migration
  def change
    rename_column :users, :media, :media_tags
    rename_column :users, :specialisations, :specialisations_tags
    rename_column :users, :subjects_themes, :subjects_tags
  end
end
