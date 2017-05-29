class Experience < ActiveRecord::Base

  attr_accessor :company_name

  belongs_to :user, touch: true
  belongs_to :company

  enum category: %w(teaching research academic professional other_category)
  enum job_type: %w(full_time part_time internship other_type)

  OPTIONS_FOR_CATEGORY = categories.keys.map { |k| [k =~ /\A(other)/ ? 'Other' : k.humanize, k] }
  OPTIONS_FOR_JOB_TYPE = job_types.keys.map { |k| [k =~ /\A(other)/ ? 'Other' : k.humanize, k] }

  validates :position, presence: true
  validates :start_month, :end_month, presence: true
  validates :start_year, :end_year, presence: true
  validates :location, presence: true
  validates :job_type, presence: true, if: -> { user.try(:role) != "artist" }
  validates :company_name, presence: true, on: :create, if: -> { user.try(:role) != "artist" }

end
