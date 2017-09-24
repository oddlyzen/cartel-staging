class AddCompanyIdToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :company_id, :integer
    add_index :opportunities, :company_id
  end
end
