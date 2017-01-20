class CreateMembership < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.string :name
      t.date :year
      t.integer :user_id
    end
  end
end
