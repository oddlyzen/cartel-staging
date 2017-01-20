class ChangeTitleFormat < ActiveRecord::Migration
  def change
    change_column :users, :title, 'integer USING CAST("title" AS integer)'
  end
end
