class Subject < ActiveRecord::Base

  belongs_to :user

  enum state: [:pending, :approved, :rejected]

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.public_options
    other = where(name: 'Other')
    where(set_display: true).where.not(name: 'Other') + other
  end

end
