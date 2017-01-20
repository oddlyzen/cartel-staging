class ChangeLanguageLevelType < ActiveRecord::Migration
  def self.up
    change_column :users, :language_level, 'integer USING CAST("residency_status" AS integer)'
  end

  def self.down
    change_column :users, :language_level, :string
  end
end
