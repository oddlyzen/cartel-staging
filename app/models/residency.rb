class Residency < ActiveRecord::Base

  belongs_to :user, touch: true

  validates :start_month, :start_year, :body, presence: true
  validates :end_month, :end_year, presence: true, if: -> { current.blank? }

end
