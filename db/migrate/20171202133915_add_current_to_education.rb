class AddCurrentToEducation < ActiveRecord::Migration
  def change
    add_column :educations, :current, :boolean
  end
end
