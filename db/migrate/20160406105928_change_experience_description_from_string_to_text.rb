class ChangeExperienceDescriptionFromStringToText < ActiveRecord::Migration
  def change
    remove_column :experiences, :description, :string
    add_column :experiences, :description, :text
  end
end
