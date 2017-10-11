class Event < ActiveRecord::Base
  TYPES = ["Exhibition", "Art Fair", "Book Launch", "Other"]
  EXHIBITION_TYPES = ["Solo", "Group"]
  belongs_to :company
  has_many :opening_times
  has_many :event_participations
  has_many :sub_events

  accepts_nested_attributes_for :opening_times
  accepts_nested_attributes_for :event_participations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :sub_events, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  validates :event_type, presence: true
  validates :type_exhibition, presence: true, if: :exhibition_event?
  validates :type_other, presence: true, if: :other_event?
  validates :city, :country, :location, :description, :start_date, :end_date, :address_1, :postcode, presence: true
  validates :company_id, presence: true

  def exhibition_event?
    event_type == "Exhibition"
  end

  def other_event?
    event_type == "Other"
  end

end
