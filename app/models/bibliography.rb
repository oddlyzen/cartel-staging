class Bibliography < ActiveRecord::Base

  belongs_to :user, touch: true

  validates :author, presence: true, if: -> { source_type != "catalogue" && pdf_url.blank? }
  validates :title, :year, presence: true, if: -> { pdf_url.blank? }
  validates :publisher, presence: true, if: -> { (source_type == "book" || source_type == "catalogue") && pdf_url.blank? }
  validates :publication_title, presence: true, if: -> { (source_type == "article" || source_type == "essay") && pdf_url.blank? }

  enum source_type: %w(book catalogue article essay review paper)

  enum participation: %w(editor writer)
  enum city: %w(city1 city2)

end
