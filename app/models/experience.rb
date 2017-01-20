class Experience < ActiveRecord::Base

  attr_accessor :company_name

  belongs_to :user, touch: true
  belongs_to :company

  enum category: %w(teaching research academic professional other_category)
  enum job_type: %w(full_time part_time internship other_type)

  OPTIONS_FOR_CATEGORY = categories.keys.map { |k| [k =~ /\A(other)/ ? 'Other' : k.humanize, k] }
  OPTIONS_FOR_JOB_TYPE = job_types.keys.map { |k| [k =~ /\A(other)/ ? 'Other' : k.humanize, k] }

  validates :position, presence: true, on: :update
  validates :start_month, presence: true, on: :update
  validates :start_year, presence: true, on: :update

end
