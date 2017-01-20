require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  let(:admin_user) { create(:user, :admin) }
  let(:artist_user) { create(:user, :artist) }

  before { login_user admin_user }

  describe '#GET index' do

    before { get :index }

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with :success }

  end

  describe 'GET #show' do

    before { get :show, id: artist_user }

    it { is_expected.to render_template(:show) }
    it { expect(assigns(:user)).to eq(artist_user) }

  end

  describe '#PUT activate' do

    before { put :activate, id: artist_user }

    it { is_expected.to redirect_to(admin_users_path) }
    it { expect(assigns(:user).active).to eq(true) }

  end

  describe '#PUT deactivate' do

    before { put :deactivate, id: artist_user }

    it { is_expected.to redirect_to(admin_users_path) }
    it { expect(assigns(:user).active).to eq(false) }

  end

end
