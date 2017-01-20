class LanguageProficiency < ActiveRecord::Base

  belongs_to :profile, touch: true
  belongs_to :language

  validates :profile, presence: true
  validates :language, presence: true
  validates :language, uniqueness: { scope: :profile_id }
  validates :level, presence: true

  enum level: %w(Basic Spoken Intermediate Fluent)

end
