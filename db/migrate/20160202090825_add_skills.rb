class AddSkills < ActiveRecord::Migration
  def change
    add_column :users, :skills, :text, array: true, default: [] 
    add_index :users, :skills, using: :gin
  end
end
