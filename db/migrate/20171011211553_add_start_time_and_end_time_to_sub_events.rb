class AddStartTimeAndEndTimeToSubEvents < ActiveRecord::Migration
  def change
    add_column :sub_events, :start_time, :time
    add_column :sub_events, :end_time, :time
  end
end
