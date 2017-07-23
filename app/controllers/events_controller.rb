class EventsController < ApplicationController
  JS_ASSETS = %w(application events).freeze

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
    @event.opening_times.new(weekday: 0)
    @event.opening_times.new(weekday: 1)
    @event.opening_times.new(weekday: 2)
    @event.opening_times.new(weekday: 3)
    @event.opening_times.new(weekday: 4)
    @event.opening_times.new(weekday: 5)
    @event.opening_times.new(weekday: 6)

    @event.event_participations.new

    @participation_users = User.where("role = ? OR role = ?", 1, 2)
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
    @event.event_participations.new if @event.event_participations.empty?
    @participation_users = User.where("role = ? OR role = ?", 1, 2)
  end

  def update
    @event = Event.find(params[:id])

    if @event.update_attributes(event_params)
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
    params.require(:event).permit(:name, :event_type, :type_other, :type_exhibition, :cover_image_url, :location, :city, :country, :address_1, :address_2, :postcode, :description, :website_link, :facebook_link, :instagram_link, :twitter_link, :company_id, :start_date, :end_date, :opening_times_attributes => [:id, :weekday, :start_time, :end_time], :event_participations_attributes => [:id, :involvement, :user_id])
  end

end
