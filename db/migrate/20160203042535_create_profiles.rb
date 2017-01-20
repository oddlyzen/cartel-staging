class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references :user, index: true
      t.text :languages, array: true, default: [], index: { using: :gin }
      t.text :skills, array: true, default: [], index: { using: :gin }
      t.text :themes, array: true, default: [], index: { using: :gin }
      t.text :media, array: true, default: [], index: { using: :gin }
      t.text :specialisations, array: true, default: [], index: { using: :gin }

      t.timestamps null: false
    end
  end
end
