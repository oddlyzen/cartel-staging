module My
  class PasswordsController < My::BaseController
    before_action :authenticate_user, only: [:update]

    def show
    end

    def update
      if @user.update(user_params.except(:current_password))
        redirect_to my_settings_path, notice: 'User password changed!'
      else
        redirect_to my_settings_path, alert: 'Passwords do not match!'
      end
    end

    private

    def user_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end

    def authenticate_user
      @user = User.authenticate(current_user.email, user_params[:current_password])
      redirect_to my_settings_path, alert: 'Current password does not match!' unless @user.present?
    end
  end
end
