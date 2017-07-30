class CreateCompanyFollowers < ActiveRecord::Migration
  def change
    create_table :company_followers do |t|
      t.integer :user_id
      t.integer :company_id

      t.timestamps null: false
    end
  end
end
