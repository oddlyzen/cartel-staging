class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tagline, :string
    add_column :users, :statement, :string
    add_column :users, :skill, :string
    add_column :users, :interest, :string
    add_column :users, :language, :string
    add_column :users, :language_level, :string
    add_column :users, :facebook_link, :string
    add_column :users, :twitter_link, :string
    add_column :users, :instagram_link, :string
    add_column :users, :from_study_month, :integer
    add_column :users, :from_study_year, :integer
    add_column :users, :to_study_month, :integer
    add_column :users, :to_study_year, :integer
  end
end
