class CreateSubEvents < ActiveRecord::Migration
  def change
    create_table :sub_events do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.text :description
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
