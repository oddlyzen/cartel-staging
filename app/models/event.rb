class Event < ActiveRecord::Base
  TYPES = ["Exhibition", "Art Fair", "Book Launch", "Other"]
  belongs_to :company
  has_many :opening_times

  accepts_nested_attributes_for :opening_times

  validates :name, presence: true
  validates :event_type, presence: true
  validates :exhibition_type, presence: true, if: :exhibition_event?
  validates :other_type, presence: true, if: :other_event?
  validates :city, :country, :location, :description, :start_date, :end_date, presence: true
  validates :company_id, presence: true

  def exhibition_event?
    event_type == "Exhibition"
  end

  def other_event?
    event_type == "Other"
  end

end
