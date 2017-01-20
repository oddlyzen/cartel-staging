class AddPresentToResidencies < ActiveRecord::Migration
  def change
    add_column :residencies, :current, :boolean, default: false
  end
end
