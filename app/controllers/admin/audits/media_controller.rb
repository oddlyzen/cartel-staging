class Admin::Audits::MediaController < Admin::BaseController
  before_action :find_medium, only: [:edit, :update, :approve, :reject]

  def index
    media = Medium.order(:state)
    @media = media.map { |medium| UserDecorator.new(medium) }
  end

  def edit
  end

  def update
    if @medium.update(medium_params)
      redirect_to admin_audits_media_path
    else
      flash[:error] = @medium.errors.full_messages
      render :edit
    end
  end

  def approve
    if @medium.update(state: 1, action_date: Date.current)
      flash[:notice] = 'Tag is approved'
      redirect_to admin_audits_media_path
    else
      flash[:notice] = 'Error approving.'
    end
  end

  def reject
    if @medium.update(state: 2, action_date: Date.current)
      flash[:notice] = 'Tag is rejected'
      redirect_to admin_audits_media_path
    else
      flash[:notice] = 'Error saving.'
    end
  end

  private

  def medium_params
    params.require(:medium).permit(:name, :name_edit_date, :state)
  end

  def find_medium
    @medium = Medium.find(params[:id])
  end
end
