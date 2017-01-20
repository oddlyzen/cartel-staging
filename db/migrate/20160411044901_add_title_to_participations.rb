class AddTitleToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :title, :string
  end
end
