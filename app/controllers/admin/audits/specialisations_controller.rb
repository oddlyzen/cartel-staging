class Admin::Audits::SpecialisationsController < Admin::BaseController

  before_action :find_specialisation, only: [:edit, :update, :approve, :reject]

  def index
    specialisations = Specialisation.order(:state)
    @specialisations = specialisations.map { |a| UserDecorator.new(a) }
  end

  def edit
  end

  def update
    if @specialisation.update(specialisation_params)
      redirect_to admin_audits_specialisations_path
    else
      flash[:error] = @specialisation.errors.full_messages
      render :edit
    end
  end

  def approve
    if @specialisation.update(state: 1, action_date: Date.current)
      flash[:notice] = 'Tag is approved'
      redirect_to admin_audits_specialisations_path
    else
      flash[:notice] = 'Error approving'
    end
  end

  def reject
    if @specialisation.update(state: 2, action_date: Date.current)
      flash[:notice] = 'Tag is rejected'
      redirect_to admin_audits_specialisations_path
    else
      flash[:notice] = 'Error rejecting'
    end
  end

  private

  def specialisation_params
    params.require(:specialisation).permit(:name, :name_edit_date, :state)
  end

  def find_specialisation
    @specialisation = Specialisation.find(params[:id])
  end
end
