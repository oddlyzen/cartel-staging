class Series < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :artwork
  belongs_to :exhibition

  has_many :artworks, -> { order(:position) }
  has_many :feed_items, as: :resource, dependent: :destroy

  validates :title, presence: true

  validates :description, :year, presence: true, on: :publish
  validates :acknowledgement, acceptance: true, on: :publish

  enum status: [:unpublished, :published]

  aasm column: :status do
    state :published
    state :unpublished, initial: true

    event :publish do
      transitions from: :unpublished, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :unpublished
    end

  end

end
