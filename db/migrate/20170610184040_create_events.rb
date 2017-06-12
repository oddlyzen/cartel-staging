class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :type
      t.string :type_other
      t.string :type_exhibition
      t.string :cover_image_url
      t.string :location
      t.string :city
      t.string :country
      t.text :description
      t.string :website_link
      t.string :facebook_link
      t.string :instagram_link
      t.string :twitter_link
      t.integer :company_id

      t.timestamps null: false
    end

    add_index :events, :company_id
  end
end
