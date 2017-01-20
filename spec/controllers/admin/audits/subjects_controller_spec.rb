require 'rails_helper'

RSpec.describe Admin::Audits::SubjectsController, type: :controller do

  let(:admin_user) { create(:user, :admin) }
  let(:subject) { create(:subject) }

  before { login_user admin_user }

  describe '#GET index' do

    before { get :index }

    it { is_expected.to render_template(:index) }
    it { expect(response).to have_http_status(:success) }

  end

  describe 'GET #edit' do

    before { get :edit, id: subject }

    it { is_expected.to render_template(:edit) }
    it { expect(assigns(:subject)).to eq(subject) }

  end

  describe 'PUT #update' do

    context 'with valid params' do

      before { put :update, id: subject, subject: attributes_for(:subject) }

      it { is_expected.to redirect_to(admin_audits_subjects_path) }

    end

    context 'with invalid params' do

      before { put :update, id: subject, subject: attributes_for(:subject, :invalid) }

      it { is_expected.to render_template(:edit) }
    end

  end

  describe 'PATCH #approve' do

    before do
      subject.update(state: :pending)
      patch :approve, id: subject
    end

    context 'with pending params' do
      it { expect(Subject.find(subject.id).approved?).to be true }
      it { is_expected.to redirect_to(admin_audits_subjects_path) }
    end
  end

  describe 'PATCH #reject' do

    before do
      subject.update(state: :rejected)
      patch :reject, id: subject
    end

    context 'with reject params' do
      it { expect(Subject.find(subject.id).rejected?).to be true }
      it { is_expected.to redirect_to(admin_audits_subjects_path) }
    end
  end

end
