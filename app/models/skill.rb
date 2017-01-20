class Skill < ActiveRecord::Base

  belongs_to :user

  enum state: [:pending, :approved, :rejected]

  validates :name, presence: true

end
