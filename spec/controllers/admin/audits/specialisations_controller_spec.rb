require 'rails_helper'

RSpec.describe Admin::Audits::SpecialisationsController, type: :controller do

  let(:admin_user) { create(:user, :admin) }
  let(:specialisation) { create(:specialisation) }

  before { login_user admin_user }

  describe '#GET index' do

    before { get :index }

    it { is_expected.to render_template(:index) }
    it { expect(response).to have_http_status(:success) }

  end

  describe 'GET #edit' do

    before { get :edit, id: specialisation }

    it { is_expected.to render_template(:edit) }
    it { expect(assigns(:specialisation)).to eq(specialisation) }

  end

  describe 'PUT #update' do

    context 'with valid params' do

      before { put :update, id: specialisation, specialisation: attributes_for(:specialisation) }

      it { is_expected.to redirect_to(admin_audits_specialisations_path) }

    end

    context 'with invalid params' do

      before { put :update, id: specialisation, specialisation: attributes_for(:medium, :invalid) }

      it { is_expected.to render_template(:edit) }
    end

  end

  describe 'PATCH #approve' do

    before do
      specialisation.update(state: :pending)
      patch :approve, id: specialisation
    end

    context 'with pending params' do
      it { expect(Specialisation.find(specialisation.id).approved?).to be true }
      it { is_expected.to redirect_to(admin_audits_specialisations_path) }
    end
  end

  describe 'PATCH #reject' do

    before do
      specialisation.update(state: :rejected)
      patch :reject, id: specialisation
    end

    context 'with reject params' do
      it { expect(Specialisation.find(specialisation.id).rejected?).to be true }
      it { is_expected.to redirect_to(admin_audits_specialisations_path) }
    end
  end

end
