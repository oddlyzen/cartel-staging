class AddStatusTextToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status_text, :string
  end
end
