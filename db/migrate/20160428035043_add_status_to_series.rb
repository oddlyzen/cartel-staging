class AddStatusToSeries < ActiveRecord::Migration
  def change
    add_column :series, :status, :integer, default: 0, null: false
  end
end
