class Opportunity < ActiveRecord::Base
  belongs_to :created_by, class_name: "User"

  enum status: %w(open closed)
end
