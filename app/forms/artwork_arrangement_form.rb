class ArtworkArrangementForm < BaseForm

  attr_accessor :artworks, :artworks_order, :series_id

  def initialize(params = {})
    @series = Series.find(params[:series_id])
    @artworks = @series.artworks
    @artworks_order = @artworks.pluck(:id).join(',')
    @new_position = params[:artworks_order].split(',').map(&:to_i) unless params[:artworks_order].nil?
  end

  def save
    if @artworks.empty?
      false
    else
      update_position(@new_position)
    end
  end

  private

  def update_position(new_position)
    ActiveRecord::Base.transaction do
      new_position.each_with_index do |id, index|
        artwork = @artworks.find(id)
        artwork.position = index
        artwork.save(validate: false)
      end
    end
  end
end
