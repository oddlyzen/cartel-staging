class ChangeColumnTypeOfCategoryInExperiences < ActiveRecord::Migration
  def up
    remove_column :experiences, :category
    add_column :experiences, :category, :integer
    add_column :experiences, :job_type, :integer
  end

  def down
    remove_column :experiences, :category
    add_column :experiences, :category, :string
    remove_column :experiences, :job_type, :integer
  end
end
