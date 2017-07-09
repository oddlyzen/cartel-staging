class OpeningTime < ActiveRecord::Base
  belongs_to :event

  def to_s
    "#{Date::DAYNAMES[weekday]}: #{start_time.strftime('%H:%M')} - #{end_time.strftime('%H:%M')}"
  end
end
