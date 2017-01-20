class FeedItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :artwork
  belongs_to :resource, polymorphic: true

  validates :user, presence: true
  validates :artwork, presence: true, if: :new_series_artwork?
  validates :resource, presence: true, if: :series_published?
  validates :kind, presence: true

  enum kind: %i(new_series_artwork user_update series_published)

end
