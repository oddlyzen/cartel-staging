class AddYearDurationToPublications < ActiveRecord::Migration
  def change
    add_column :publications, :start_year, :integer
    add_column :publications, :end_year, :integer
  end
end
