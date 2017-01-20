class SeriesArtwork < ActiveRecord::Base
  belongs_to :artwork
  belongs_to :series
end
