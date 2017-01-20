class AddResourceToFeedItems < ActiveRecord::Migration
  def change
    add_column :feed_items, :resource_type, :string
    add_column :feed_items, :resource_id, :integer
  end
end
