class ChangeUserRegistrationNewData < ActiveRecord::Migration
  def change
  	remove_column :users, :initial, :string
  	remove_column :users, :grade, :string
  	remove_column :users, :gallery, :string
  	remove_column :users, :from_exhibit_month, :integer
  	remove_column :users, :from_exhibit_year, :integer
  	remove_column :users, :to_exhibit_month, :integer
  	remove_column :users, :to_exhibit_year, :integer
  	remove_column :users, :from_record_year, :string
    remove_column :users, :to_record_year, :string
  	add_column :users, :from_exhibit_date, :date
  	add_column :users, :to_exhibit_date, :date
  	add_column :users, :representation, :string
  	add_column :users, :position, :string
  	add_column :users, :company_name, :string
  	add_column :users, :exhibit_description, :string
  	add_column :users, :from_record_year, :date
    add_column :users, :to_record_year, :date
  end
end
