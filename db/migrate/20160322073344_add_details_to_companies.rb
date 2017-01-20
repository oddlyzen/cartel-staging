class AddDetailsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :organization_type_ids, :integer, array: true, default: []
    add_index :companies, :organization_type_ids, using: :gin
    add_column :companies, :description, :text
    add_column :companies, :country, :string
    add_column :companies, :state, :string
    add_column :companies, :phone, :string
    add_column :companies, :email, :string
    add_column :companies, :position, :integer
  end
end
