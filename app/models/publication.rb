class Publication < ActiveRecord::Base

  belongs_to :user, touch: true

  enum participation: %w(editor writer)
  enum category: %w(book catalogue article essay review paper)

  validates :category, :title, :publication_title, :day, :month, :year, presence: true
  validates :participation, presence: true, if: -> { user.role == "professional" }
end
