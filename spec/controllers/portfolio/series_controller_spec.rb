require 'rails_helper'

RSpec.describe Portfolio::SeriesController, type: :controller do

  let(:user) { create(:user) }
  let!(:series) { create(:series, user: user) }
  let!(:series_2) { create(:series, user: user) }
  let!(:artwork) { create(:artwork, user: user, series: series) }
  let!(:artwork_2) { create(:artwork, user: user, series: series) }

  before { login_user user }

  describe '#GET index' do

    before { get :index }

    it { is_expected.to render_template(:index) }
    it { expect(assigns(:series)).to include(series, series_2) }

  end

  describe '#GET show' do

    before { get :show, id: series }

    it { is_expected.to render_template(:show) }
    it { expect(assigns(:series)).to eq(series) }

  end

  describe 'GET #edit' do

    before { get :edit, id: series }

    it { is_expected.to render_template(:edit) }
    it { expect(assigns(:series)).to eq(series) }

  end

  describe 'POST #create' do

    context 'with valid params' do

      it { expect { create_series }.to change(Series, :count).by(1) }
      it { create_series; is_expected.to redirect_to(:back) }

      context 'series is not published by default' do
        it { create_series; expect(assigns(:series).published?).to be_falsey }
      end

    end

    context 'with invalid params' do

      it { expect { create_invalid_series }.to change(Series, :count).by(0) }
      it { create_invalid_series; is_expected.to redirect_to(:back) }
    end

  end

  describe 'PATCH #update' do

    before do
      patch :update, id: series, series_update_form: series_update_form_params
    end

    context 'with valid params' do

      let(:series_update_form_params) do
        {
          id: series.id,
          series_attributes: attributes_for(:series, title: 'Realistic Art'),
          exhibition_attributes: attributes_for(:exhibition)
        }
      end

      it { series.reload; expect(series.title).to eq('Realistic Art') }
      it { is_expected.to redirect_to portfolio_series_path(series) }

    end

    context 'with invalid params' do

      let(:series_update_form_params) do
        {
          id: series.id,
          series_attributes: attributes_for(:series, :invalid),
          exhibition_attributes: attributes_for(:exhibition)
        }
      end

      it { is_expected.to render_template(:edit) }

    end

  end

  describe 'PATCH #publish' do

    before do
      patch :publish, id: series, series_update_form: series_update_form_params
    end

    context 'with valid params' do

      let(:series_update_form_params) do
        {
          id: series.id,
          series_attributes: attributes_for(:series, title: 'Realistic Art'),
          exhibition_attributes: attributes_for(:exhibition)
        }
      end

      it { series.reload; expect(series.title).to eq('Realistic Art') }
      it { series.reload; expect(series.published?).to be_truthy }
      it { is_expected.to redirect_to portfolio_series_path(series) }

    end

    context 'with invalid params' do

      let(:series_update_form_params) do
        {
          id: series.id,
          series_attributes: attributes_for(:series, :invalid_for_publish),
          exhibition_attributes: attributes_for(:exhibition)
        }
      end
      it { series.reload; expect(series.published?).to be_falsey }
      it { is_expected.to redirect_to edit_portfolio_series_path(series) }

    end

  end

  describe 'DELETE #destroy' do

    it { expect { delete :destroy, id: series }.to change(Series, :count).by(-1) }
    it { delete :destroy, id: series; is_expected.to redirect_to portfolio_series_index_path }

  end

  describe 'PATCH #set_cover' do
    before { patch :set_cover, id: series, artwork_id: artwork.id }

    it { series.reload; expect(series.artwork_id).to eq(artwork.id) }
    it { is_expected.to redirect_to edit_portfolio_series_path(series) }

  end

  describe 'PATCH #unpublish' do
    before do
      series.publish!
      patch :unpublish, id: series
    end

    it { series.reload; expect(series.unpublished?).to be_truthy }
    it { is_expected.to redirect_to portfolio_series_path(series) }

  end

  describe 'GET #rearrange' do
    before { get :rearrange, id: series }

    it { is_expected.to render_template(:rearrange) }
    it { expect(assigns(:artwork_arrangement_form)).to be_a ArtworkArrangementForm }
  end

  describe 'PATCH #set_order' do
    before do
      patch :set_order, id: series, artwork_arrangement_form: { artworks_order: "#{artwork.id},#{artwork_2.id}", series_id: series.id }
    end

    it { artwork.reload; expect(artwork.position).to eq(0) }
    it { is_expected.to redirect_to edit_portfolio_series_path(series) }
  end

  private

  def create_series
    post :create, series_id: series.id, series: attributes_for(:series)
  end

  def create_invalid_series
    post :create, series_id: series.id, series: attributes_for(:series, :invalid)
  end

end
