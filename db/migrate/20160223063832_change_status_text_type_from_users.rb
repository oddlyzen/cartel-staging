class ChangeStatusTextTypeFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :status_text
    add_column :users, :status_text, :text, array: true, default: []
    add_index :users, :status_text, using: :gin
  end

  def down
    remove_index :users, name: :index_users_on_status_text
    remove_column :users, :status_text
    add_column :users, :status_text, :string
  end
end
