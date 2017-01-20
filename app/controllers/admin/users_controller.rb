module Admin
  class UsersController < Admin::BaseController
    before_action :prepare_user, only: [:show, :activate, :deactivate]

    def index
      @users = User.all
    end

    def show
    end

    def activate
      @user.update_attributes(active: true)
      flash[:notice] = "User #{@user.email} was successfully activated."
      redirect_to admin_users_path
    end

    def deactivate
      @user.update_attributes(active: false)
      flash[:notice] = "User #{@user.email} was successfully deactivated."
      redirect_to admin_users_path
    end

    private

    def prepare_user
      @user = User.find(params[:id])
    end

  end
end
