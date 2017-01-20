class AddEditDatesToSpecialisations < ActiveRecord::Migration
  def change
    add_column :specialisations, :action_date, :date
    add_column :specialisations, :name_edit_date, :date
    add_column :specialisations, :user_with_same_tags, :integer, array: true, default: []
  end
end
