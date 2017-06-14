class CreateOpeningTimes < ActiveRecord::Migration
  def change
    create_table :opening_times do |t|
      t.integer :weekday
      t.time :start_time
      t.time :end_time
      t.integer :event_id

      t.timestamps null: false
    end
  end
end
