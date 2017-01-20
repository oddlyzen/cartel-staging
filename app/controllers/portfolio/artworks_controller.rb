module Portfolio
  class ArtworksController < Portfolio::BaseController
    respond_to :js

    before_action :set_series, only: [:index, :update, :destroy, :upload, :bulk_destroy, :bulk_update]
    before_action :reindex_artworks, only: [:index]

    def index
      render :reload if request.xhr?
    end

    def update
      @artwork_update_form = ArtworkUpdateForm.new(artwork_params.merge(user_id: @user.id, id: params[:id]))
      if @artwork_update_form.save
        redirect_to portfolio_series_artworks_path(@artwork_update_form.artwork.series), notice: 'Update successful'
      else
        flash[:error] = 'Please check your form again and re-submit'
        redirect_to portfolio_series_artworks_path(@series)
      end
    end

    def destroy
      @artwork = @series.artworks.find(params[:id])

      if @artwork.destroy
        redirect_to portfolio_series_artworks_path(@series)
      else
        redirect_to portfolio_series_artworks_path(@series), alert: 'Sorry, an error has occurred! Please try again'
      end
    end

    def upload
      @all_series = @user.series
      @unassorted_artworks = @user.artworks.unassorted
      @bulk_upload = BulkUploadForm.new
      @bulk_group = BulkGroupForm.new
    end

    def bulk_upload
      @bulk_upload = BulkUploadForm.new(bulk_upload_params.merge(user_id: @user.id))

      if @bulk_upload.save
        redirect_to :back, notice: 'New series created'
      else
        flash[:alert] = 'Please check your form again and re-submit'
        redirect_to :back
      end
    end

    def bulk_group
      @bulk_group = BulkGroupForm.new(bulk_group_params.merge(user_id: @user.id))

      if @bulk_group.save
        flash[:notice] = 'Artworks successfully moved'
      else
        flash[:alert] = @bulk_group.errors.full_messages
      end
      redirect_to :back
    end

    def bulk_update
      @artwork_bulk_update_form = ArtworkBulkUpdateForm.new(artwork_params)

      if @artwork_bulk_update_form.save
        redirect_to :back, notice: 'Bulk Update succesful'
      else
        redirect_to edit_portfolio_series_path(@series), alert: @artwork_bulk_update_form.errors.full_messages.to_sentence
      end
    end

    def bulk_destroy
      if params[:ids].empty?
        redirect_to :back, alert: 'No artworks selection found. Please try again.'
      else
        @series = @user.series.find(params[:series_id])
        @series.artworks.where(id: params[:ids].values).destroy_all
        redirect_to edit_portfolio_series_path(@series), notice: 'Artworks deleted'
      end
    end

    private

    def artwork_params
      params.require(:artwork).permit(
        :ids, :series_id, :month, :year, :for_sale, :edition, :edition_of, :title, :description, :height, :width, :length, :unit, :subject_themes, :image_url, :artist_inventory, :gallery_inventory, :signature, :signature_location, :country, :city, :private_collection, :public_collection, :notes, :signed_dated, :acknowledgement, collaborator_ids: [], medium_ids: [], subject_ids: []
      )
    end

    def bulk_upload_params
      params.require(:bulk_upload_form).permit(:image_urls)
    end

    def bulk_group_params
      params.require(:bulk_group_form).permit(:series, artwork_ids: [])
    end

    def set_series
      @series = @user.series.find(params[:series_id]) if params[:series_id]
    end

    def reindex_artworks
      @artwork = params[:id].blank? ? @series.artworks.first : @series.artworks.find(params[:id])
      @artworks = @series.artworks
      artwork_index = @artworks.find_index(@artwork)
      last_index = @artworks.length - 1
      prepare_order(artwork_index, last_index)
    end

    def prepare_order(artwork_index, last_index)
      @next_id = @artworks[artwork_index + 1].id unless artwork_index == last_index
      @prev_id = @artworks[artwork_index - 1].id unless artwork_index.zero?

      if artwork_index.zero?
        @prev_id = @artworks[-1].id
      elsif artwork_index == last_index
        @next_id = @artworks[0].id
      end
    end
  end
end
