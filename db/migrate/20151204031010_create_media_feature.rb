class CreateMediaFeature < ActiveRecord::Migration
  def change
    create_table :media_features do |t|
      t.string :title
      t.string :description
      t.string :link
      t.integer :user_id
    end
  end
end
