class OauthsController < ApplicationController
  skip_before_action :require_login
  before_action :prepare_and_load_user, only: :callback

  def oauth
    login_at(params[:provider])
  end

  def callback
    redirect_to new_registration_path(user_params_from_provider)
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def prepare_and_load_user
    @user = login_from(params[:provider])
    redirect_to edit_my_profile_path, notice: 'Thank you. Please continue to the next page of your registration.' if @user.present?
  end

  def user_params_from_provider
    user_params = sorcery_fetch_user_hash(params[:provider])[:user_info].slice('email', 'first_name', 'last_name', 'id')
    save_oauth_to_session(params[:provider], user_params.delete('id'))
    user_params
  end

  def save_oauth_to_session(provider, uid)
    session['oauth_info'] = {}.tap do |info|
      info['provider'] = provider
      info['uid'] = uid
    end
  end

end
