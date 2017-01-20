class ArtworkBulkUpdateForm < BaseForm

  validate :atleast_one_artwork_selected

  def initialize(params = {})
    @ids = prepare_ids(params[:ids])
    @artwork_params = params.except(:ids)
    @artworks = artwork_assign_attributes
  end

  def save
    if valid?
      ActiveRecord::Base.transaction do
        @artworks.each do |artwork|
          if artwork.series.published?
            artwork.save(context: :series_save)
          else
            artwork.save
          end
        end
      end
    end
    errors.empty?
  end

  private

  def prepare_ids(ids)
    ids.split(',').map(&:to_i)
  end

  def atleast_one_artwork_selected
    errors.add('Artwork: ', 'No artwork selection found') if @ids.blank?
  end

  def artwork_assign_attributes
    artworks = Artwork.find(@ids)
    artworks.each { |artwork| artwork.assign_attributes(@artwork_params) }
  end

end
