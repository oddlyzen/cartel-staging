module My
  class CompaniesController < My::BaseController

    def index
      @user = UserDecorator.new(@user)
      @companies = current_user.companies.map { |c| CompanyDecorator.new(c) }
    end

    def new
      @company_form = My::CompanyForm.new
    end

    def create
      @company_form = My::CompanyForm.new(company_form_params)

      if @company_form.save
        redirect_to my_companies_path, notice: 'New organisation created! Stay tuned for more features'
      else
        flash[:error] = @company_form.errors.full_messages.to_sentence
        render :new
      end
    end

    def show
      @company_presenter = My::CompanyPresenter.new(user_id: @user.id, company_id: params[:id])
    end

    def edit
      @company = @user.companies.find(params[:id])
      @company_form = My::CompanyForm.new(existing_company: @company)
    end

    def update
      @company = @user.companies.find(params[:id])
      @company_form = My::CompanyForm.new(company_form_params.merge(existing_company: @company))

      if @company_form.save
        redirect_to my_companies_path
      else
        flash[:error] = @company_form.errors.full_messages.to_sentence
        render :edit
      end
    end

    private

    def company_form_params
      params.require(:my_company_form).permit(company_attributes: company_attributes_whitelist).tap do |params|
        params[:company_attributes][:owner_id] = current_user.id
      end
    end

    def company_attributes_whitelist
      [
        :image_url, :name, :motto, :country, :state, :established_in, :address_1, :address_2, :contact, :about_us,
        :facebook, :twitter, :instagram, :description, :country, :state, :phone, :email, :location,
        :position, :website, :opening_time, :closing_time, organization_type_ids: []
      ]
    end

  end
end
