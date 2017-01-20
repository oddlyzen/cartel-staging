class ProfessionalsController < ApplicationController
  before_action :require_login
  before_action :set_pagination, only: [:index]

  def index
    render :reload if request.xhr?
  end

  def show
    @current_professional = User.professional.find(params[:id])
    @professional = UserDecorator.new(@current_professional)
  end

  private

  def set_pagination
    professionals = User.professional.map { |a| UserDecorator.new(a) }
    @professionals = Kaminari.paginate_array(professionals).page(params[:page]).per(9)
  end
end
