class Education < ActiveRecord::Base
  belongs_to :user, touch: true

  validates :start_year, :end_year, :institution, :country, presence: true
end
