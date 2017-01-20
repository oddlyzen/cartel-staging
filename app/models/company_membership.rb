class CompanyMembership < ActiveRecord::Base
  enum state: %i(pending approved rejected)

  belongs_to :user
  belongs_to :company

  validates :user_id, presence: true

  include AASM

  aasm column: :state, whiny_transitions: false, enum: true do
    state :pending, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: :pending, to: :approved
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end
  end
end
