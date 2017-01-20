class CompanyDecorator < BaseDecorator

  def opening_hours
    if @model.opening_time && @model.closing_time
      "#{@model.opening_time&.strftime('%H:%M')} - #{@model.closing_time&.strftime('%H:%M')}"
    end
  end

  def location
    [@model.state, @model.country].reject(&:blank?).join(', ')
  end

  def full_address
    "#{@model.address_1} #{@model.address_2}"
  end

end
