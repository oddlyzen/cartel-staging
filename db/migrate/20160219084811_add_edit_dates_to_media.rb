class AddEditDatesToMedia < ActiveRecord::Migration
  def change
    add_column :media, :action_date, :date
    add_column :media, :name_edit_date, :date
    add_column :media, :user_with_same_tags, :integer, array: true, default: []
  end
end
