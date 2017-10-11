class AddClosedToOpeningTimes < ActiveRecord::Migration
  def change
    add_column :opening_times, :closed, :boolean
  end
end
