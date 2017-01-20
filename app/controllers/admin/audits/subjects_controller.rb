class Admin::Audits::SubjectsController < Admin::BaseController

  before_action :find_subject, only: [:edit, :update, :approve, :reject]

  def index
    subjects = Subject.order(:state)
    @subjects = subjects.map { |a| UserDecorator.new(a) }
  end

  def edit
  end

  def update
    if @subject.update(subject_params)
      redirect_to admin_audits_subjects_path
    else
      flash[:error] = @subject.errors.full_messages
      render :edit
    end
  end

  def approve
    if @subject.update(state: 1, action_date: Date.current)
      flash[:notice] = 'Tag is approved'
      redirect_to admin_audits_subjects_path
    else
      flash[:notice] = 'Error approving'
    end
  end

  def reject
    if @subject.update(state: 2, action_date: Date.current)
      flash[:notice] = 'Tag is rejected'
      redirect_to admin_audits_subjects_path
    else
      flash[:notice] = 'Error rejecting'
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :name_edit_date, :state)
  end

  def find_subject
    @subject = Subject.find(params[:id])
  end
end
