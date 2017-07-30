class OpportunitiesController < ApplicationController
  JS_ASSETS = %w(application opportunities).freeze

  before_action :require_login
  before_action :set_pagination, only: [:index]

  def index
    render :reload if request.xhr?
  end

  def show
    @opportunity = Opportunity.find(params[:id])
  end

  def new
    @opportunity = Opportunity.new
  end

  def create
    @opportunity = Opportunity.new(opportunity_params)

    if @opportunity.save
      redirect_to opportunities_path, notice: 'New Opportunity Created!'
    else
      flash[:error] = @opportunity.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @opportunity = Opportunity.find(params[:id])
    return redirect_to opportunity_path(@opportunity) if @opportunity.created_by != current_user
  end

  def update
    @opportunity = Opportunity.find(params[:id])

    if @opportunity.update_attributes(opportunity_params)
      flash[:success] = "#{@opportunity.title} Updated Successfully!"
      redirect_to opportunities_path
    else
      flash[:error] = @opportunity.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def set_pagination
    @opportunities = Kaminari.paginate_array(Opportunity.open).page(params[:page]).per(12)
  end

  def opportunity_params
    params.require(:opportunity).permit(:title, :description, :status, :created_by_id)
  end

end
