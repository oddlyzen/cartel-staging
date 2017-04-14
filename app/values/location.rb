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

  # NOW you can use this anywhere, the same way you use state options for country
  def self.cities_for_state(state, country)
    if state.nil?
      {}
    else
      CS.cities(state, country)
    end
  end


end
