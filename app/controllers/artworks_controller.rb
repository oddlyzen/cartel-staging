class ArtworksController < ApplicationController
  before_action :set_artist, only: [:show, :index]

  def show
    @artwork = ArtworkDecorator.new(@artist.artworks.find(params[:id]))
    @collaboration = @artwork.artwork_collaborators.find_by(user_id: current_user.id) if current_user
  end

  def index
    @artworks = @artist.artworks.map { |a| ArtworkDecorator.new(a) }
    @series = @artist.series.includes(:artwork)
  end

  private

  def set_artist
    user = User.artist.find(params[:artist_id])
    @artist = UserDecorator.new(user)
  end

end
