class EventParticipation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user, :involvement, presence: true
end
