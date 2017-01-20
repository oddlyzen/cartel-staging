class Connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates :friend, presence: true
  validates :user, presence: true
  validates :user_id, uniqueness: { scope: :friend_id } # can connect once only

  enum status: [:pending, :accepted, :rejected]

  include AASM

  aasm column: :status, enum: true do
    state :pending, initial: true
    state :accepted
    state :rejected

    event :accept do
      transitions from: [:pending, :rejected], to: :accepted
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end
  end
end
