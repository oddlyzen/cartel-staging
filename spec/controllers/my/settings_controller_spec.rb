require 'rails_helper'

RSpec.describe My::SettingsController, type: :controller do

  let!(:user) { create(:user) }

  before { login_user user }

  describe '#GET show' do

    before { get :show }

    it { is_expected.to render_template(:show) }
    it { expect(assigns(:user)).to eq(user) }

  end

  describe '#PUT update' do

    context 'with valid params' do

      let(:new_email) { 'new@email.com' }
      let(:new_user_attributes) { attributes_for(:user, email: new_email) }

      before { put :update, user: new_user_attributes }

      it { expect(assigns(:user).errors).to be_empty }
      it { expect(assigns(:user).email).to eq(new_email) }
      it { is_expected.to redirect_to(my_settings_path) }

    end

    context 'with invalid params' do

      let(:new_email) { '' }
      let(:new_user_attributes) { attributes_for(:user, email: new_email) }

      before { put :update, user: new_user_attributes }
      it { expect(assigns(:user).errors).not_to be_empty }

      it { expect(user.reload.email).not_to eq(new_email) }
      it { is_expected.to render_template(:show) }

    end

  end

  describe '#GET account' do
    before { xhr :get, :account }

    it { is_expected.to render_template(:account) }
    it { expect(assigns(:user)).to eq(user) }

  end

  describe '#PUT deactivate' do
    before { put :deactivate, user: attributes_for(:user, reason_deactivating: 'Other') }

    it { is_expected.to redirect_to(root_path) }
    it { expect(assigns(:user)).not_to be_active }
    it { expect(assigns(:user).reason_deactivating).to eq('Other') }
  end

end
