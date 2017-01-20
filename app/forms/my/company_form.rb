class My::CompanyForm

  include ActiveModel::Model
  include ActiveModel::Validations

  attr_reader :company

  def initialize(params = {})
    @company = params.delete(:existing_company) || Company.new
    super(params)
  end

  def company_attributes=(company_params)
    @company = Company.pending.find_or_initialize_by(name: company_params[:name]) unless @company.persisted?
    @company.assign_attributes(company_params)

    unless company_params['opening_time(4i)'].present? && company_params['opening_time(5i)'].present?
      @company.opening_time = nil
    end

    unless company_params['closing_time(4i)'].present? && company_params['closing_time(5i)'].present?
      @company.closing_time = nil
    end
  end

  def save
    @company.save!
  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.full_messages.each { |message| errors.add(:base, message) }
    false
  end

  def options_for_public_organization_type
    OrganizationType.approved.where(public_option: true).pluck(:name, :id)
  end

  def options_for_private_organization_type
    OrganizationType.approved.where(public_option: false).pluck(:name, :id)
  end

end
