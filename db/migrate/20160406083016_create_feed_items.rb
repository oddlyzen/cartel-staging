class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :artwork, index: true, foreign_key: true
      t.integer :kind, null: false

      t.timestamps
    end
  end
end
