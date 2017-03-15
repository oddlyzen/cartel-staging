class ArtworkDecorator < BaseDecorator

  def exhibited_at
    "Exhibited at: #{@model&.series&.exhibition&.venue&.name}"
  end

  def series_title
    "Series: #{@model.series&.title}"
  end

  def creator_name
    "#{@model.creator.first_name} #{@model.creator.last_name}"
  end

  def description_snippet
    if @model.description
      truncate(@model.description, length: 150)
    else
      'Description not available'
    end
  end

  def title
    @model.title.blank? ? 'Untitled' : @model.title
  end

  def year
    @model.year || '---'
  end

  def dimension
    if @model.height && @model.width && @model.unit
      "#{@model.height} x #{@model.width} #{@model.unit}"
    else
      '---'
    end
  end

  def medium
    if @model&.media.any?
      @model.media.join(', ')
    else
      '---'
    end
  end

  def subjects_themes
    @model.subjects.join(', ').presence || '---'
  end

end
