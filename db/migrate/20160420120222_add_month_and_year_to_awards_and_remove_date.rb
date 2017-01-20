class AddMonthAndYearToAwardsAndRemoveDate < ActiveRecord::Migration
  def change
    add_column :awards, :month, :integer
    add_column :awards, :year, :integer

    remove_column :awards, :date, :date
  end
end
