class RenameCompanyUsersToCompanyMemberships < ActiveRecord::Migration
  def up
      rename_table :company_users, :company_memberships
    end

   def down
      rename_table :company_memberships, :company_users
   end
end
