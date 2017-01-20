module Admin
  class CompaniesController < Admin::BaseController

    def index
      @companies = Company.all.map { |c| CompanyDecorator.new(c) }
    end

    def edit
      @company = Company.find(params[:id])
    end

    def update
      @company = Company.find(params[:id])
      if @company.update_attributes(company_params)
        redirect_to admin_companies_path
      else
        flash[:error] = @company.errors.full_messages.to_sentence
        render :edit
      end
    end

    private

    def company_params
      params.require(:company).permit(
        :image_url, :name, :motto, :location, :established_in,
        :address, :opening_time, :closing_time, :contact,
        :about_us, :facebook, :twitter, :instagram
      )
    end

  end
end
