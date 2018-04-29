class AddDefaultLanguages < ActiveRecord::Migration
  require 'csv'
  
  def up
    csv_text = File.read(File.join(File.dirname(__FILE__), "../top_74_languages.csv"))
    csv = CSV.parse(csv_text, headers: false)
    csv.each do |row|
      Language.create!(name: row[0], state: 'approved')
    end
  end

  def down
    defaults = Language.defaults
    defaults.each{ |d| d.destroy }
  end
end
