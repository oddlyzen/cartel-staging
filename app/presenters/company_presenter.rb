class CompanyPresenter

  def initialize(company_id)
    @company = Company.find(company_id)
    @members = @company.approved_members
  end

  def artists
    @members.artist.where.not(id: @company.owner_id).map do |artist|
      UserDecorator.new(artist)
    end
  end

  def professionals
    @members.professional.includes(:experiences).where.not(id: @company.owner_id)
  end

  def professionals_with_experience
    professionals.map do |professional|
      {
        professional: UserDecorator.new(professional),
        experience: professional.experiences.where(company_id: @company.id).first
      }
    end
  end

  def owner
    UserDecorator.new(@company.owner)
  end

end
