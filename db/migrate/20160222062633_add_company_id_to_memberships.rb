class AddCompanyIdToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :company_id, :integer
  end
end
