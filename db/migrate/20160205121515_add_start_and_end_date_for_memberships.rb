class AddStartAndEndDateForMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :start_date, :date
    add_column :memberships, :end_date, :date
  end
end
