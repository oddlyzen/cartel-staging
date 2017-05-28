class Participation < ActiveRecord::Base

  belongs_to :user, touch: true

  validates :month, :year, :title, :description, presence: true

end
