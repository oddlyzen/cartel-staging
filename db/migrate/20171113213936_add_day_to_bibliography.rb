class AddDayToBibliography < ActiveRecord::Migration
  def change
    add_column :bibliographies, :day, :integer
  end
end
