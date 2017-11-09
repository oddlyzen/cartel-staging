class Exhibition < ActiveRecord::Base

  attr_accessor :venue_name

  belongs_to :user, touch: true
  belongs_to :venue, class_name: 'Company'
  belongs_to :representation, class_name: 'Company'

  has_many :series

  validates :title, :start_month, :start_year, :end_month, :end_year, :venue, :location, presence: true, unless: :attachment_is_present?
  validates :record_start_year, :record_end_year, presence: true, if: :attachment_is_present?
  validates :category, presence: true, if: -> { user.try(:role) == "artist" && !attachment_is_present? }
  validates :pdf_url, presence: true, if: -> { title.blank? }

  enum category: %w(in_solo in_group)
  enum grade: [:a, :b, :c, :d]

  scope :with_attachment, -> { where(category: nil) }

  NOTICE = %(
    I acknowledge that the information provided for publishing is true and correct for public viewing and that I am the original author of these artworks.
  ).freeze

  OPTIONS_FOR_CATEGORY = categories.keys.map { |k| [k =~ /\A(in_)/ ? k.split('_').last.humanize : k.humanize, k] }

  private

  def attachment_is_present?
    !pdf_url.blank?
  end

end
