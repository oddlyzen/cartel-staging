class Opportunity < ActiveRecord::Base
  belongs_to :created_by, class_name: "User"
  belongs_to :company, class_name: "Company"

  enum status: %w(open closed)

  validates :title, :description, :status, presence: true
  validates :company_id, presence: true

  scope :open, -> { where(status: "open") }
end
