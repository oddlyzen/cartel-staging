class ExperienceDecorator < BaseDecorator
  include DateFormat

  def company_location
    [@model.company&.name, @model.state].compact.join(', ')
  end

  def full_position
    [@model.position, @model.category&.capitalize].compact.join(', ')
  end

end
