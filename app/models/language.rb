class Language < ActiveRecord::Base
  belongs_to :user
  scope :defaults, -> { where(user: nil) }

  has_many :language_proficiencies
  has_many :profiles, through: :language_proficiencies

  enum state: [:pending, :approved, :rejected]

  validates :name, presence: true
end
