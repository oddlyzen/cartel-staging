class My::CompanyPresenter

  attr_reader :company

  def initialize(params = {})
    @user = User.find(params[:user_id])
    @company = @user.companies.find(params[:company_id])
  end

  def memberships
    @company.company_memberships
  end

  def members
    @company.members
  end

  def non_members
    User.where.not(id: members.pluck(:id))
  end

end
