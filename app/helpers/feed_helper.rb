module FeedHelper
  def artwork_path(artwork)
    content_tag :i do
      link_to artwork.title || 'Untitled', artist_artwork_path(artwork.user_id, artwork.id), remote: true, data: { toggle: 'modal', target: '#modal' }
    end
  end

  def series_path(series)
    content_tag :b do
      link_to(series&.title, artist_series_path(series.user.id, series.id))
    end
  end

end
