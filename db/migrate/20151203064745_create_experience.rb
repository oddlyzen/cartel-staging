class CreateExperience < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.date :date
      t.string :position
      t.string :company
      t.string :state
      t.string :country
      t.string :type
      t.string :description
      t.string :link
      t.integer :user_id
    end
  end
end
