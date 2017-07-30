class Opportunity < ActiveRecord::Base
  belongs_to :created_by, class_name: "User"

  enum status: %w(open closed)

  validates :title, :description, :status, presence: true

  scope :open, -> { where(status: "open") }
end
