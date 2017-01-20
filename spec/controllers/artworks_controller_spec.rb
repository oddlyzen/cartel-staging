require 'rails_helper'

RSpec.describe ArtworksController, type: :controller do
  let(:user) { create(:user) }
  let(:artwork) { create(:artwork, user: user) }
  let!(:collaboration) { create(:artwork_collaborator, artwork: artwork, collaborator: user) }

  before { login_user user }

  describe 'GET #show' do
    before { xhr :get, :show, artist_id: user.id, id: artwork.id }

    it { is_expected.to render_template(:show) }
    it { is_expected.to respond_with :success }
    it { expect(assigns(:artwork)).to eq artwork }
    it { expect(assigns(:collaboration)).to eq collaboration }

  end

  describe 'GET #index' do
    before { get :index, artist_id: user }

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with :success }
  end
end
