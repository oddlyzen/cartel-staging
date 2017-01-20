class ChangePublicationsCategoryTypeFromStringToInteger < ActiveRecord::Migration
  def change
    remove_column :publications, :category, :string
    add_column :publications, :category, :integer
  end
end
