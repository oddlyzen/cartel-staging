class AddInvolvementStringToExhibition < ActiveRecord::Migration
  def change
    add_column :exhibitions, :involvement_string, :string
  end
end
