class Location
  def self.options_for_state
    CS.get(:my).values + CS.get(:sg).values
  end

  def self.options_for_country
    CS.countries.values.sort
  end

  def self.state_options_for_country(country)
    if country.nil?
      {}
    else
      country_code = CS.countries.invert[country]
      CS.states(country_code).values
    end
  end
end
