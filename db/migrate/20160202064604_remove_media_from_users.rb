class RemoveMediaFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :media
    add_column :users, :media, :text, array: true, default: []
    add_index :users, :media, using: :gin
  end

  def self.down
    add_column :users, :media, :string
  end
end
