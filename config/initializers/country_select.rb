CountrySelect::FORMATS[:with_alpha2] = lambda do |country|
  "#{country.alpha2}"
end