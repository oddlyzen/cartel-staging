module DateHelper
  def single_full_date(model)
    [model.day, Date::ABBR_MONTHNAMES[model.month.to_i], model.year].compact.join(' ')
  end

  def date_in_year(date)
    date.instance_of?(Date) ? date.strftime('%Y') : date
  end

  def single_date(model)
    [Date::ABBR_MONTHNAMES[model.month.to_i], model.year].compact.join(' ')
  end

  def date_in_range(model)
    return '-' if model.start_year.blank? && model.end_year.blank?
    start_duration = "#{model.start_month && Date::ABBR_MONTHNAMES[model.start_month]} #{model.start_year}"
    end_duration = model.try(:current) ? 'Present' : "#{model.end_month && Date::ABBR_MONTHNAMES[model.end_month]} #{model.end_year}"
    "#{start_duration} - #{end_duration}"
  end

end
