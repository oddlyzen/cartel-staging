class Portfolio::SeriesController < Portfolio::BaseController

  before_action :set_series, only: [:show, :edit, :update, :destroy, :set_cover, :rearrange, :set_order, :publish, :unpublish]

  def new
    @series = @user.series.build
  end

  def create
    @series = @user.series.build(series_params)
    if @series.save
      redirect_to :back, notice: 'Series has been created'
    else
      redirect_to :back, alert: 'Something went wrong. Please try again!'
    end
  end

  def index
    @series = @user.series.includes(:artwork)
  end

  def show
    @exhibition = ExhibitionDecorator.new(@series.exhibition)
  end

  def edit
    @series_update_form = SeriesUpdateForm.new(user_id: @user.id, id: @series.id)
  end

  def update
    @series_update_form = SeriesUpdateForm.new(series_update_form_params.merge(user_id: @user.id))

    if @series_update_form.save
      redirect_to portfolio_series_path(@series), notice: 'Series has been updated'
    else
      flash.now[:error] = @series_update_form.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @series.destroy
      redirect_to portfolio_series_index_path, notice: 'Series Deleted'
    else
      redirect_to portfolio_series_index_path, alert: 'Something went wrong. Please try again!'
    end
  end

  def rearrange
    @artwork_arrangement_form = ArtworkArrangementForm.new(series_id: @series.id)
    gon.artworks = @artwork_arrangement_form.artworks.to_json
  end

  def set_order
    @artwork_arrangement_form = ArtworkArrangementForm.new(arrange_artworks_form_params.merge(series_id: @series.id))
    if @artwork_arrangement_form.save
      redirect_to edit_portfolio_series_path(@series), notice: 'New positions saved'
    else
      redirect_to edit_portfolio_series_path(@series), alert: 'Something went wrong. Please try again!'
    end
  end

  def set_cover
    if !params[:artwork_id].nil? && @series.update(artwork_id: params[:artwork_id])
      redirect_to edit_portfolio_series_path(@series), notice: 'Series cover was updated'
    else
      redirect_to edit_portfolio_series_path(@series), alert: 'No artworks selection found. Please try again.'
    end
  end

  def publish
    @series_update_form = SeriesUpdateForm.new(series_update_form_params.merge(user_id: @user.id))
    if @series_update_form.publish
      redirect_to portfolio_series_path(@series), notice: 'Series was published for public viewing! Your network will be able to see your series'
    else
      redirect_to edit_portfolio_series_path(@series), alert: @series_update_form.errors.full_messages.to_sentence
    end
  end

  def unpublish
    if @series.unpublish!
      redirect_to portfolio_series_path(@series), notice: 'Series unpublished. It will remain in your portfolio and no longer be available for public view'
    else
      redirect_to edit_portfolio_series_path(@series), alert: 'Something went wrong. Please try again!'
    end
  end

  private

  def series_params
    params.require(:series).permit(:title, :link)
  end

  def series_update_form_params
    params.require(:series_update_form).permit(
      :id,
      series_attributes: [:title, :link, :year, :description, :acknowledgement, :exhibition_id],
      exhibition_attributes: [:title, :start_date, :link, :pdf_url, :state, :country, :category, :venue, :representation]
    )
  end

  def arrange_artworks_form_params
    params.require(:artwork_arrangement_form).permit(:artworks_order)
  end

  def set_series
    @series = @user.series.includes(:artworks).find(params[:id])
  end

end
