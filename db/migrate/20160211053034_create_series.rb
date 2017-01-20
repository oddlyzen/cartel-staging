class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.references :user, index: true
      t.references :artwork, index: true
      t.references :exhibition, index: true
      t.string :title
      t.text :description
      t.date :year
      t.boolean :acknowledgement, default: false

      t.timestamps null: false
    end
  end
end
