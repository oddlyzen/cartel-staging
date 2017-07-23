class EventParticipation < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  has_many :event_notifications

  validates :user, :involvement, presence: true

  after_create :create_notification, if: Proc.new { |e| e.event.event_type == "Exhibition" }

  def create_notification
    self.event_notifications.create(user_id: self.user_id, status: "pending") if self.event.event_type == "Exhibition"
  end
end
