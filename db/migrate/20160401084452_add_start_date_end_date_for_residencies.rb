class AddStartDateEndDateForResidencies < ActiveRecord::Migration
  def change
    rename_column :residencies, :date, :start_date
    add_column :residencies, :end_date, :date
  end
end
