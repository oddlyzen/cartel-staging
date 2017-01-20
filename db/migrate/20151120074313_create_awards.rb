class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :title, null: false
      t.date :date
      t.string :awarding_body
      t.string :prize
      t.references :user, index: true, foreign_key: true
    end
  end
end
