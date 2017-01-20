class Language < ActiveRecord::Base
  belongs_to :user

  has_many :language_proficiencies
  has_many :profiles, through: :language_proficiencies

  enum state: [:pending, :approved, :rejected]

  validates :name, presence: true
end
