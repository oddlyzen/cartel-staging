class RemoveArtistProfessionalStatusTextIndexFromUsers < ActiveRecord::Migration
  def up
    remove_index :users, :artist_status_text
  end

  def down
    add_index :users, :artist_status_text, using: :gin
  end
end
