class CreateLanguageProficiencies < ActiveRecord::Migration
  def change
    create_table :language_proficiencies do |t|
      t.references :language, index: true, foreign_key: true, null: false
      t.references :profile, index: true, foreign_key: true, null: false
      t.integer :level
    end
  end
end
