class AddEditDatesToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :action_date, :date
    add_column :subjects, :name_edit_date, :date
    add_column :subjects, :user_with_same_tags, :integer, array: true, default: []
  end
end
