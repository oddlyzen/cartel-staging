class SubEvent < ActiveRecord::Base
  belongs_to :event

  validates :name, :description, :start_date, :end_date, presence: true
end
