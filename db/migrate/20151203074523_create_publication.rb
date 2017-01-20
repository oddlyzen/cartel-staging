class CreatePublication < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :participation
      t.string :type
      t.string :title
      t.string :publication_title
      t.string :country
      t.string :state
      t.string :publisher
      t.date :date
      t.string :edition
      t.string :editor
      t.string :issue
      t.string :page_numbers
      t.string :link
      t.integer :user_id
    end
  end
end
