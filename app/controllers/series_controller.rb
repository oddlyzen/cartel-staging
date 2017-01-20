class SeriesController < ApplicationController

  before_action :set_artist, only: [:show]

  def show
    @series = SeriesDecorator.new(@artist.series.find(params[:id]))
    @artworks = @series.artworks.map { |a| ArtworkDecorator.new(a) }
    @exhibition = ExhibitionDecorator.new(@series.exhibition)
  end

  private

  def set_artist
    @artist = UserDecorator.new(User.find(params[:artist_id]))
  end

end
