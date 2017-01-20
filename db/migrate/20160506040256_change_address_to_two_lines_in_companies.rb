class ChangeAddressToTwoLinesInCompanies < ActiveRecord::Migration
  def change
    rename_column :companies, :address, :address_1
    add_column :companies, :address_2, :string
  end
end
