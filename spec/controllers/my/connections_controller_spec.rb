require 'rails_helper'

RSpec.describe My::ConnectionsController, type: :controller do

  let!(:user) { create(:user) }
  let!(:friend) { create(:user, email: 'friend@mail.com') }

  before { login_user user }

  describe '#GET index' do
    before { get :index }

    it { is_expected.to render_template(:index) }
    it { expect(assigns(:user)).to eq(user) }

  end

  describe '#POST create' do
    before(:each) do
      request.env['HTTP_REFERER'] = request.referer
    end

    context 'with valid params' do
      before { post :create, id: friend }

      it { is_expected.to redirect_to(request.referer) }
      it { expect(flash[:notice]).to eq 'Connection has been requested' }
      it { expect(user.connections.count).to eq(1) }
      it { expect(user.connections.last.status).to eq('pending') }
    end

    context 'when already requested' do
      before do
        post :create, id: friend
        post :create, id: friend
      end

      it { is_expected.to redirect_to(request.referer) }
      it { expect(flash[:alert]).to eq 'Connection already requested.' }
    end

  end

  describe '#PUT accept' do
    context 'with existing connection' do
      before do
        user.connections.create(friend: friend)
        login_user friend
        put :accept, id: user
      end

      it { is_expected.to redirect_to(my_connections_path) }
      it { expect(flash[:notice]).to eq 'Connection accepted.' }
      it { expect(user.connections.last.status).to eq('accepted') }
    end

    context 'with already accepted connection' do
      before do
        user.connections.create(friend: friend, status: 'accepted')
        login_user friend
        put :accept, id: user
      end

      it { is_expected.to redirect_to(my_connections_path) }
      it { expect(flash[:alert]).to eq 'Connection is already accepted.' }
    end

  end

  describe '#PUT reject' do
    context 'with existing connection' do
      before do
        user.connections.create(friend: friend)
        login_user friend
        put :reject, id: user
      end

      it { is_expected.to redirect_to(my_connections_path) }
      it { expect(flash[:notice]).to eq 'Connection rejected.' }
      it { expect(user.connections.last.status).to eq('rejected') }
    end

    context 'with already rejected connection' do
      before do
        user.connections.create(friend: friend, status: 'rejected')
        login_user friend
        put :reject, id: user
      end

      it { is_expected.to redirect_to(my_connections_path) }
      it { expect(flash[:alert]).to eq 'Connection is already rejected.' }
    end

  end

  describe '#delete destroy' do
    before do
      create(:connection, *connection_traits, connection_attributes)
      login_user user
      delete :destroy, id: friend
    end

    context 'with active connection' do
      let(:connection_traits) { [:accepted] }
      let(:connection_attributes) { { user: user, friend: friend } }

      it { is_expected.to redirect_to(my_connections_path) }
      it { expect(flash[:notice]).to eq 'Connection Removed' }
      it { expect(assigns(:connection)).to be_destroyed }
    end

    context 'with passive connection' do
      let(:connection_traits) { [:accepted] }
      let(:connection_attributes) { { user: friend, friend: user } }

      it { is_expected.to redirect_to(my_connections_path) }
      it { expect(flash[:notice]).to eq 'Connection Removed' }
      it { expect(assigns(:connection)).to be_destroyed }
    end

    context 'already disconnected' do
      let(:connection_traits) { nil }
      let(:connection_attributes) { nil }
      it { is_expected.to redirect_to(my_connections_path) }
      it { expect(flash[:alert]).to eq 'Connection is already disconnected.' }
    end
  end
end
