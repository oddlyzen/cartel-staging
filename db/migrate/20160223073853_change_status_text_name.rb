class ChangeStatusTextName < ActiveRecord::Migration
  def change
      rename_column :users, :status_text, :artist_status_text
  end
end
