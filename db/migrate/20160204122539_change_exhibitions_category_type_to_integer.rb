class ChangeExhibitionsCategoryTypeToInteger < ActiveRecord::Migration
  def up
    remove_column :exhibitions, :category, :string
    add_column :exhibitions, :category, :integer
  end

  def down
    remove_column :exhibitions, :category, :integer
    add_column :exhibitions, :category, :string
  end
end
