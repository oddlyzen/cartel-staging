class AddLinkToSeries < ActiveRecord::Migration
  def change
    add_column :series, :link, :string
  end
end
