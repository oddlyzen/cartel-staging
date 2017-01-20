class ExhibitionDecorator < BaseDecorator

  def title
    @model.title || 'Title not available'
  end

  def location
    if @model.venue.present? && @model.country.present?
      "#{@model.venue.name}, #{@model.country}"
    else
      'Location not available'
    end
  end

  def start_year
    @model.start_year || 'Year started not available'
  end

end
