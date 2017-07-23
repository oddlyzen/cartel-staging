class CreateEventNotifications < ActiveRecord::Migration
  def change
    create_table :event_notifications do |t|
      t.integer :user_id
      t.integer :event_participation_id
      t.integer :status

      t.timestamps null: false
    end
  end
end
