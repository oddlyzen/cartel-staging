class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.string :title
      t.text :description
      t.integer :created_by_id
      t.integer :status

      t.timestamps null: false
    end
  end
end
