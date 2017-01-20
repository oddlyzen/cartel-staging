class Year
  def self.collection_options
    (1936..Time.zone.today.year).reverse_each
  end
end
