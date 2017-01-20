class ChangeDurationToIntegerAndRemoveDateInPublications < ActiveRecord::Migration
  def change
    add_column :publications, :start_month, :integer
    add_column :publications, :end_month, :integer

    remove_column :publications, :date, :date
  end
end
