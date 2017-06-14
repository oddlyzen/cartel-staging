class EventsController < ApplicationController
  before_action :require_login
  before_action :set_pagination, only: [:index]

  def index
    render :reload if request.xhr?
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path, notice: 'New Event Created!'
    else
      flash[:error] = @event.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.save
      flash[:success] = "#{@event.name} Updated Successfully!"
      redirect_to events_path
    else
      flash[:error] = @event.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def set_pagination
    @events = Kaminari.paginate_array(Event.all).page(params[:page]).per(12)
  end

  def event_params
    params.require(:event).permit(:name, :type, :type_other, :type_exhibition, :cover_image_url, :location, :city, :country, :description, :website_link, :facebook_link, :instagram_link, :twitter_link, :company_id, :opening_time_ids => [])
  end

end
