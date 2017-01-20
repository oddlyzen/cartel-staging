require 'rails_helper'

RSpec.describe My::PasswordsController, type: :controller do

  let(:user) { create(:user, password: '123123123', password_confirmation: '123123123') }

  before { login_user user }

  describe '#GET show' do
    before { xhr :get, :show }

    it { is_expected.to render_template(:show) }
    it { expect(assigns(:user)).to eq(user) }

  end

  describe '#PUT update' do

    context 'with valid params' do
      before do
        put :update, user: attributes_for(
          :user,
          current_password: '123123123',
          password: 'password',
          password_confirmation: 'password'
        )
      end
      it { is_expected.to redirect_to(my_settings_path) }
      it { expect(flash[:notice]).to eq 'User password changed!' }
    end

    context 'with invalid params' do
      before do
        put :update, user: attributes_for(
          :user,
          current_password: '',
          password: 'password',
          password_confirmation: 'password'
        )
      end
      it { expect(flash[:alert]).to eq 'Current password does not match!' }
      it { is_expected.to redirect_to(my_settings_path) }
    end

  end
end
