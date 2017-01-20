class AddYearDurationToBibiliography < ActiveRecord::Migration
  def change
    add_column :bibliographies, :start_year, :integer
    add_column :bibliographies, :end_year, :integer
  end
end
