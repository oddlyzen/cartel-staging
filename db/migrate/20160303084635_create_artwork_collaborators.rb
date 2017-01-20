class CreateArtworkCollaborators < ActiveRecord::Migration
  def change
    create_table :artwork_collaborators do |t|
      t.references :artwork, index: true
      t.references :user, index: true
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
