class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :motto
      t.string :location
      t.date :established_in
      t.string :address
      t.string :opening_times
      t.string :contact
      t.string :about_us
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.integer :professional_user_id
    end
  end
end
