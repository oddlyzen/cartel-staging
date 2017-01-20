class SetDisplayMediaSubjectsSpecialisation < ActiveRecord::Migration
  def change
    add_column :media, :set_display, :boolean, default: false
    add_column :subjects, :set_display, :boolean, default: false
  end
end
