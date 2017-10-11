class OpeningTime < ActiveRecord::Base
  belongs_to :event

  def to_s
    if self.closed?
      "#{Date::DAYNAMES[weekday]}: CLOSED"
    else
      "#{Date::DAYNAMES[weekday]}: #{start_time.strftime('%H:%M')} - #{end_time.strftime('%H:%M')}"
    end
  end
end
