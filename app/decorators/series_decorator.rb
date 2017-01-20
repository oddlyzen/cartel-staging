class SeriesDecorator < BaseDecorator

  def title
    @model.title || 'Untitled'
  end

  def year
    @model.year&.strftime('%Y') || '---'
  end

  def description
    if @model.description
      truncate(@model.description, length: 150)
    else
      'Description not available'
    end
  end

end
