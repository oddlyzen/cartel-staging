class CreateExhibitions < ActiveRecord::Migration
  def change
    create_table :exhibitions do |t|
      t.date :start_date
      t.date :end_date
      t.string :title
      t.string :category
      t.string :venue
      t.string :state
      t.string :country
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
