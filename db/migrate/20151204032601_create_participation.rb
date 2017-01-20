class CreateParticipation < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.date :date
      t.string :description
      t.string :link
      t.integer :user_id
    end
  end
end
