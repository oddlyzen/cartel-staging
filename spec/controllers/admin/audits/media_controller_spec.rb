require 'rails_helper'

RSpec.describe Admin::Audits::MediaController, type: :controller do

  let(:admin_user) { create(:user, :admin) }
  let(:medium) { create(:medium) }

  before { login_user admin_user }

  describe '#GET index' do

    before { get :index }

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with(:success) }

  end

  describe 'GET #edit' do

    before { get :edit, id: medium }

    it { is_expected.to render_template(:edit) }
    it { expect(assigns(:medium)).to eq(medium) }

  end

  describe 'PUT #update' do

    context 'with valid params' do

      before { put :update, id: medium, medium: attributes_for(:medium) }

      it { is_expected.to redirect_to(admin_audits_media_path) }

    end

    context 'with invalid params' do

      before { put :update, id: medium, medium: attributes_for(:medium, :invalid) }

      it { is_expected.to render_template(:edit) }
    end

  end

  describe 'PATCH #approve' do

    before do
      medium.update(state: :pending)
      patch :approve, id: medium
    end

    context 'with pending params' do
      it { expect(Medium.find(medium.id).approved?).to be true }
      it { is_expected.to redirect_to(admin_audits_media_path) }
    end
  end

  describe 'PATCH #reject' do

    before do
      medium.update(state: :rejected)
      patch :reject, id: medium
    end

    context 'with reject params' do
      it { expect(Medium.find(medium.id).rejected?).to be true }
      it { is_expected.to redirect_to(admin_audits_media_path) }
    end
  end

end
