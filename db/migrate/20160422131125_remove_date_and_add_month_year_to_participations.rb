class RemoveDateAndAddMonthYearToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :month, :integer
    add_column :participations, :year, :integer

    remove_column :participations, :date
  end
end
