require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  let(:user) { create(:user) }

  before { login_user(user) }

  describe 'GET #create' do
    before { get :create, email: user.email }

    it { is_expected.to redirect_to(root_path) }
    it { expect(ActionMailer::Base.deliveries).not_to be_empty }
  end

  describe 'GET #edit' do
    context 'id valid' do

      before { get :edit, id: user.reset_password_token }

      it { is_expected.to render_template(:edit) }
      it { expect(assigns(:user)).to eq user }
      it { expect(assigns(:token)).to eq user.reset_password_token }
    end

    context 'id invalid' do

      before { get :edit, id: 'invalid-id' }

      it { is_expected.to redirect_to(root_path) }
    end
  end

  describe 'GET #update' do
    context 'invalid user' do
      before do
        get :update, id: 'invalid-user', user: { password: '123', password_confirmation: '123' }
      end

      it { is_expected.to redirect_to(root_path) }
    end

    context 'valid params' do
      before do
        @old_password = user.crypted_password
        get :update, id: user.reset_password_token, user: { password: '123', password_confirmation: '123' }
      end

      it { user.reload; expect(user.crypted_password).to_not eq @old_password }
      it { is_expected.to redirect_to(root_path) }
    end

    context 'invalid params' do
      before do
        @old_password = user.crypted_password
        get :update, id: user.reset_password_token, user: { password: '123', password_confirmation: '' }
      end

      it { user.reload; expect(user.crypted_password).to eq @old_password }
      it { is_expected.to render_template(:edit) }
    end
  end

end
