class Month
  def self.collection_options
    Hash[Date::MONTHNAMES.compact.zip(1..12)]
  end
end
