module My
  class MembershipsController < My::BaseController

    before_action :set_company, only: [:create, :destroy, :approve, :reject]

    def create
      @membership = @company.company_memberships.build(user_id: params[:user_id])
      if @membership.save
        redirect_to my_company_path(@company), notice: 'User added to company!'
      else
        redirect_to my_company_path(@company), alert: 'Something went wrong. Please try again!'
      end
    end

    def destroy
      @membership = @company.company_memberships.find_or_initialize_by(user_id: params[:member_id])

      if !@membership.new_record? && @membership.destroy
        redirect_to my_company_path(@company), notice: 'User was removed from company!'
      else
        redirect_to my_company_path(@company), alert: 'Something went wrong. Please try again!'
      end
    end

    def approve
      @membership = @company.company_memberships.find_by(id: params[:id])

      if @membership.approve!
        redirect_to :back, notice: 'User approved!'
      else
        redirect_to :back, alert: 'Something went wrong. Please try again!'
      end
    end

    def reject
      @membership = @company.company_memberships.find_by(id: params[:id])

      if @membership.reject!
        redirect_to :back, notice: 'User rejected!'
      else
        redirect_to :back, alert: 'Something went wrong. Please try again!'
      end
    end

    private

    def set_company
      @company = @user.companies.find(params[:company_id])
    end

  end
end
