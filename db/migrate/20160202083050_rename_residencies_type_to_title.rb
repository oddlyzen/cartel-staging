class RenameResidenciesTypeToTitle < ActiveRecord::Migration
  def change
    rename_column :residencies, :type, :title
    rename_column :publications, :type, :category
    rename_column :experiences, :type, :category
  end
end
