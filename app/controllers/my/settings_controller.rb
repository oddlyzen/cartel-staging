module My
  class SettingsController < My::BaseController

    def show
    end

    def update
      if @user.update_attributes(user_params)
        redirect_to my_settings_path, notice: 'Your settings have been updated!'
      else
        flash[:error] = 'Please check your form again and re-submit'
        render :show
      end
    end

    def account
    end

    def deactivate
      @user.update_attributes(active: false, reason_deactivating: params[:user][:reason_deactivating])
      logout
      redirect_to root_path, notice: 'Your account has successfully been deactivated'
    end

    private

    def user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :title,
        :first_name, :initial, :last_name, :date_of_birth
      )
    end

  end
end
