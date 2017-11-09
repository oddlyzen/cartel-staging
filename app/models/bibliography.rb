class Bibliography < ActiveRecord::Base

  belongs_to :user, touch: true

  validates :title, :month, :year, presence: true, if: -> { pdf_url.blank? }
  validates :publisher, presence: true, if: -> { source_type == "book" && pdf_url.blank? }

  enum source_type: %w(book catalogue article essay review paper)

  enum participation: %w(editor writer)
  enum city: %w(city1 city2)

end
