class RenameProfessionalToOwnerInCompanies < ActiveRecord::Migration
  def change
    rename_column :companies, :professional_user_id, :owner_id
  end
end
