class ArtworkCollaborator < ActiveRecord::Base
  belongs_to :artwork
  belongs_to :collaborator, class_name: 'User', foreign_key: 'user_id'

  validates :artwork, presence: true
  validates :collaborator, presence: true

  enum status: [:pending, :accepted, :rejected]

  include AASM

  aasm column: :status, whiny_transitions: false, enum: true do
    state :pending, initial: true
    state :accepted
    state :rejected

    event :accept do
      transitions from: :pending, to: :accepted
    end

    event :reject do
      transitions from: :pending, to: :rejected
    end
  end
end
