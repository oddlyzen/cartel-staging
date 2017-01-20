module DateFormat

  def duration
    months_present = start_month.present? && end_month.present?
    years_present = start_year.present? && end_year.present?

    return '-' unless years_present
    if months_present
      start_duration = "#{Date::ABBR_MONTHNAMES[start_month]} #{start_year}"
      end_duration = try(:current) ? 'Present' : "#{Date::ABBR_MONTHNAMES[end_month]} #{end_year}"
      "#{start_duration} - #{end_duration}"
    else
      "#{start_year} - #{end_year}"
    end
  end

end
