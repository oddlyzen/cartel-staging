class AddSpecialisationToUser < ActiveRecord::Migration
  def change
    add_column :users, :specialisations, :text, array: true, default: []
    add_index :users, :specialisations, using: :gin
  end
end
