require 'rails_helper'

RSpec.describe OauthsController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #callback' do
    context 'with a linked user with authentication' do
      before do
        expect_any_instance_of(OauthsController).to receive(:login_from)
          .with('facebook').and_return(Authentication.new)

        get :callback, provider: 'facebook'
      end

      it { is_expected.to redirect_to(edit_my_profile_path) }
    end

    context 'with a new user' do
      let(:provider) { 'facebook' }
      let(:code) { '123' }
      let(:oauth_user_params) do
        { 'first_name' => 'John', 'last_name' => 'Appleseed', 'email' => 'john@pan.com', 'id' => '123456' }
      end
      let(:redirect_user_params) do
        oauth_user_params.slice('first_name', 'last_name', 'email')
      end

      before do
        expect_any_instance_of(OauthsController).to receive(:sorcery_fetch_user_hash)
          .with(provider).and_return(user_info: oauth_user_params)
        expect_any_instance_of(OauthsController).to receive(:login_from).and_return(false)

        get :callback, provider: provider, code: code
      end

      it { is_expected.to redirect_to(new_registration_path(redirect_user_params)) }
    end
  end
end
