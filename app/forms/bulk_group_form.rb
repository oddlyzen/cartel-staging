class BulkGroupForm < BaseForm

  attr_accessor :user, :series, :artwork_ids

  validates :user, :series, :artwork_ids, presence: true

  def initialize(params = {})
    if params[:user_id]
      @user = User.find(params[:user_id])
      @series = @user.series.find(params[:series])
      @artwork_ids = params[:artwork_ids]
    end
  end

  def save
    if valid?
      ActiveRecord::Base.transaction do
        update_artworks
        set_cover_photo
      end
    end
    errors.empty?
  end

  private

  def update_artworks
    @user.artworks.where(id: @artwork_ids).each do |artwork|
      series_changed = artwork.series != @series
      artwork.update_attribute(:series, @series)
      trigger_new_series_artwork_feed_item(artwork: artwork) if series_changed && artwork.series.published?
    end
  end

  def set_cover_photo
    artwork = @series.artwork || Artwork.find_by(id: @artwork_ids[0])
    @series.update_attributes!(artwork: artwork)
  end

  def trigger_new_series_artwork_feed_item(attributes)
    FeedItem.create(attributes) do |feed_item|
      feed_item.user = @user
      feed_item.kind = :new_series_artwork
    end
  end
end
