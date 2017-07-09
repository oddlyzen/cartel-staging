class Event < ActiveRecord::Base
  TYPES = ["Exhibition", "Art Fair", "Book Launch", "Other"]
  EXHIBITION_TYPES = ["Solo", "Two Person", "Group", "Award", "Other"]
  belongs_to :company
  has_many :opening_times

  accepts_nested_attributes_for :opening_times

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
