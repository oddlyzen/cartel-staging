class AddCountryStateToAwards < ActiveRecord::Migration
  def change
    add_column :awards, :country, :string
    add_column :awards, :state, :string
  end
end
