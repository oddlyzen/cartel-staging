class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.references :user, index: true
      t.string :name
      t.integer :state, default: 0

      t.timestamps null: false
    end
  end
end

