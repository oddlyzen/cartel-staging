class CreateCompanyUsers < ActiveRecord::Migration
  def change
    create_table :company_users do |t|
      t.references :company, index: true
      t.references :user, index: true
      t.integer :state
      t.timestamps null: false
    end
  end
end
