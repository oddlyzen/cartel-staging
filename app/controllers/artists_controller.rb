class ArtistsController < ApplicationController
  before_action :require_login
  before_action :set_pagination, only: [:index]

  def index
    render :reload if request.xhr?
  end

  def show
    @current_artist = User.artist.find(params[:id])
    @artist = UserDecorator.new(@current_artist)
  end

  private

  def set_pagination
    artists = User.artist.includes(:profile).map { |a| UserDecorator.new(a) }.sort_by(&:name)
    @artists = Kaminari.paginate_array(artists).page(params[:page]).per(12)
  end

end
