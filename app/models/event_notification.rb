class EventNotification < ActiveRecord::Base
  belongs_to :user
  belongs_to :event_participation

  enum status: %w(pending accepted ignored)

  scope :pending, -> { where(status: "pending") }
end
