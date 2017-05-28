class MediaFeature < ActiveRecord::Base

  belongs_to :user, touch: true

  validates :month, :year, :title, presence: true

end
