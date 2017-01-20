class CreateOrganizationTypes < ActiveRecord::Migration
  def change
    create_table :organization_types do |t|
      t.references :user, index: true
      t.string :name
      t.integer :state, default: 0
      t.boolean :public_option, default: false

      t.timestamps null: false
    end
  end
end
