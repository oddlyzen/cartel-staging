class AddWebsiteToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :website, :string
    add_column :companies, :opening_time, :time
    add_column :companies, :closing_time, :time
    remove_column :companies, :opening_times
  end
end
