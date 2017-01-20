class CreateSpecialisations < ActiveRecord::Migration
  def change
    create_table :specialisations do |t|
      t.string :name
      t.integer :user_id
      t.integer :state, default: 0
      t.timestamps null: false
    end
  end
end
