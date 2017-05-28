class Award < ActiveRecord::Base

  belongs_to :user, touch: true

  validates :year, :month, :title, :awarding_body, presence: true

end
