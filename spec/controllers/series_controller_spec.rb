require 'rails_helper'

RSpec.describe SeriesController, type: :controller do

  let(:artist) { create(:user, :artist) }
  let(:exhibition) { create(:exhibition, user: artist) }
  let(:series) { create(:series, user: artist, exhibition: exhibition) }
  let!(:artwork) { create(:artwork, user: artist, series: series) }

  before { login_user create(:user) }

  describe 'GET #show' do

    before { get :show, artist_id: artist.id, id: series.id }

    it { is_expected.to render_template(:show) }
    it { is_expected.to respond_with :success }

    it { expect(assigns(:series)).to eq(series) }
    it { expect(assigns(:artworks)).to include(artwork) }
    it { expect(assigns(:exhibition)).to eq(exhibition) }

  end

end
