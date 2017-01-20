class CompaniesController < ApplicationController
  before_action :require_login
  before_action :prepare_company, only: [:show, :join, :leave]

  def index
    @companies = Company.includes(:owner).active.page(params[:page]).per(9)
    render :reload if request.xhr?
  end

  def show
    @company = CompanyDecorator.new(@company)
    @company_presenter = CompanyPresenter.new(@company.id)
  end

  def join
    @membership = @company.company_memberships.find_or_initialize_by(user_id: current_user.id)

    if @membership.new_record? && @membership.save
      redirect_to company_path(@company), notice: 'You have joined the company'
    else
      redirect_to company_path(@company), alert: 'You already joined the company'
    end
  end

  def leave
    @membership = @company.company_memberships.find_or_initialize_by(user_id: current_user.id)

    if !@membership.new_record? && @membership.destroy
      redirect_to company_path(@company), notice: 'You have left the company'
    else
      redirect_to company_path(@company), alert: 'You are not a member of the company'
    end
  end

  private

  def prepare_company
    @company = Company.find(params[:id])
    redirect_to companies_path, flash: { error: 'Invalid Company!' } if @company.pending?
  end

end
