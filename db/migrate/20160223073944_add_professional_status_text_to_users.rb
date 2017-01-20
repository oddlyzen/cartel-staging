class AddProfessionalStatusTextToUsers < ActiveRecord::Migration
  def change
    add_column :users, :professional_status_text, :text, array: true, default: []
  end
end
