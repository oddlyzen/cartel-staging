class AddFormDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nationality_country, :string
    add_column :users, :residency_status, :string
    add_column :users, :based_country, :string
    add_column :users, :based_state, :string
    add_column :users, :current_status, :string
    add_column :users, :commission, :string
    add_column :users, :media, :string
    add_column :users, :subjects_themes, :string
    add_column :users, :from_exhibit_month, :integer
    add_column :users, :from_exhibit_year, :integer
    add_column :users, :to_exhibit_month, :integer
    add_column :users, :to_exhibit_year, :integer
    add_column :users, :exhibit_title, :string
    add_column :users, :participation, :string
    add_column :users, :grade, :string
    add_column :users, :venue, :string
    add_column :users, :gallery, :string
    add_column :users, :exhibit_country, :string
    add_column :users, :exhibit_state, :string
    add_column :users, :link, :string
    add_column :users, :from_record_year, :integer
    add_column :users, :to_record_year, :integer
    add_column :users, :acknowledgement, :string
  end
end
