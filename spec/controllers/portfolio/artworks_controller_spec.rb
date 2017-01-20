require 'rails_helper'

RSpec.describe Portfolio::ArtworksController, type: :controller do

  let(:user) { create(:user) }
  let(:series) { create(:series, user: user) }
  let(:series2) { create(:series, user: user) }
  let!(:artwork) { create(:artwork, user: user, series: series) }

  before { login_user user }

  describe 'GET #index' do
    context 'with artwork #id' do
      before { xhr :get, :index, series_id: series.id, id: artwork.id }

      it { is_expected.to render_template('portfolio/artworks/reload') }
      it { is_expected.to respond_with :success }
    end

    context 'without artwork #id' do
      before { xhr :get, :index, series_id: series.id }

      it { is_expected.to render_template('portfolio/artworks/reload') }
      it { is_expected.to respond_with :success }
    end

  end

  describe 'PATCH #update' do
    context 'with valid params' do
      before { patch :update, series_id: series, id: artwork, artwork: attributes_for(:artwork, title: 'Mona Lisa') }

      it { artwork.reload; expect(artwork.title).to eq('Mona Lisa') }
      it { is_expected.to redirect_to(portfolio_series_artworks_path(series.id)) }
    end

    context 'with valid series change' do
      before { patch :update, series_id: series, id: artwork, artwork: attributes_for(:artwork, title: 'Mona Lisa', series_id: series2.id) }

      it { artwork.reload; expect(artwork.title).to eq('Mona Lisa') }
      it { is_expected.to redirect_to(portfolio_series_artworks_path(series2.id)) }
    end

    context 'with invalid params' do
      before { patch :update, series_id: series, id: artwork, artwork: attributes_for(:artwork, :invalid) }

      it { artwork.reload; expect(artwork.image_url).to_not eq('') }
      it { is_expected.to redirect_to(portfolio_series_artworks_path(series.id)) }
    end
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, series_id: series, id: artwork }

    context 'successful' do
      it { expect(assigns(:artwork)).to eq(artwork) }
      it { expect(assigns(:artwork)).to be_destroyed }
      it { is_expected.to redirect_to(portfolio_series_artworks_path(series)) }
    end

    context 'unsuccessful' do
      before { allow_any_instance_of(Artwork).to receive(:destroy).and_return(false) }
      it { is_expected.to redirect_to(portfolio_series_artworks_path(series)) }
    end
  end

  describe 'GET #upload' do
    before { get :upload, series_id: series }

    it { expect(assigns(:all_series)).to contain_exactly(series) }
    it { expect(assigns(:bulk_upload)).to be_a(BulkUploadForm) }
    it { expect(assigns(:bulk_group)).to be_a(BulkGroupForm) }
    it { is_expected.to render_template(:upload) }
  end

  describe 'POST #bulk_upload' do
    let(:bulk_upload_params) do
      { image_urls: build_list(:artwork, 3).map { |artwork_attrs| artwork_attrs[:image_url] }.join(',') }
    end

    before { post :bulk_upload, series_id: series, bulk_upload_form: bulk_upload_params }

    context 'on successful save' do
      it { expect(Artwork.count).to eq(4) }
    end

    it { is_expected.to redirect_to(:back) }
  end

  describe 'POST #bulk_group' do
    let(:artworks) { create_list(:artwork, 2, user: user) }
    let(:artwork_ids) { [artworks[0].id, artworks[1].id] }

    before { post :bulk_group, bulk_group_form: { series: series.id, artwork_ids: artwork_ids } }

    context 'on successful save' do
      it 'should update records' do
        aggregate_failures do
          artworks.each do |artwork|
            expect(artwork.reload.series).to eq(series)
          end
        end
      end
    end

    it { is_expected.to redirect_to(:back) }
  end

  describe 'PATCH #bulk_update' do
    let(:artworks) { create_list(:artwork, 2, user: user, series: series, title: 'Some artwork') }
    let(:artwork_ids) { artworks.map(&:id).join(',') }
    let(:artwork_params) { attributes_for(:artwork, title: 'Some other artwork').merge(ids: artwork_ids) }
    before { patch :bulk_update, series_id: series, artwork: artwork_params }

    context 'on successful update' do
      it 'should update records' do
        aggregate_failures do
          artworks.each do |artwork|
            expect(artwork.reload.title).to eq(artwork_params[:title])
          end
        end
      end
    end

    it { is_expected.to redirect_to(:back) }
  end

  describe 'DELETE #bulk_destroy' do
    let(:artwork_2) { create(:artwork, user: user, series: series) }
    let(:artwork_3) { create(:artwork, user: user, series: series) }
    let(:artwork_id_params) do
      {
        '1' => artwork.id,
        '2' => artwork_2.id,
        '3' => artwork_3.id
      }
    end

    before { delete :bulk_destroy, series_id: series, ids: artwork_id_params }

    context 'with artwork id params' do
      it { expect(assigns(:series).artworks.count).to eq(0) }
      it { is_expected.to redirect_to(edit_portfolio_series_path(series)) }
    end

    context 'without artwork id params' do
      let(:artwork_id_params) { {} }
      it { is_expected.to redirect_to(:back) }
    end
  end

end
