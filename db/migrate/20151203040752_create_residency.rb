class CreateResidency < ActiveRecord::Migration
  def change
    create_table :residencies do |t|
      t.date :date
      t.string :body
      t.string :type
      t.string :country
      t.string :state
      t.integer :user_id
    end
  end
end
