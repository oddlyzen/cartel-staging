class EventsController < ApplicationController
  JS_ASSETS = %w(application events).freeze

  before_action :require_login
  before_action :set_pagination, only: [:index]

  def index
    render :reload if request.xhr?
  end

  def show
    @event = Event.find(params[:id])
    @my_participation = @event.event_participations.where(user_id: current_user.id).last
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

  def add_to_profile
    if params[:status].present? && params[:event_notification_id].present?
      event_notification = EventNotification.find(params[:event_notification_id])
      event_notification.update_attributes(status: params[:status])

    end

    @event = Event.find(params[:id])

    if params[:status] == "ignored"
      redirect_to event_path(@event)
      return
    end

    return if @event.event_type != "Exhibition"

    @my_participation = @event.event_participations.where(user_id: current_user.id).last

    new_exhibition = current_user.exhibitions.new
    new_exhibition.title = @event.name
    new_exhibition.start_month = @event.start_date.month
    new_exhibition.start_year = @event.start_date.year
    new_exhibition.end_month = @event.end_date.month
    new_exhibition.end_year = @event.end_date.year
    new_exhibition.category = @event.type_exhibition
    new_exhibition.location = @event.location
    new_exhibition.involvement_string = @my_participation.involvement
    new_exhibition.venue_id = @event.company_id
    if new_exhibition.save
      @my_participation.update_attributes(added_to_profile: true)
    end

    redirect_to event_path(@event)
  end

  private

  def set_pagination
    @events = Kaminari.paginate_array(Event.all).page(params[:page]).per(12)
  end

  def event_params
    params.require(:event).permit(:name, :event_type, :type_other, :type_exhibition, :cover_image_url, :location, :city, :country, :address_1, :address_2, :postcode, :description, :website_link, :facebook_link, :instagram_link, :twitter_link, :company_id, :start_date, :end_date, :opening_times_attributes => [:id, :weekday, :start_time, :end_time], :event_participations_attributes => [:id, :involvement, :user_id])
  end

end
