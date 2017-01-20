require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let!(:user) { create(:user) }
  let(:company) { create(:company) }
  let(:company_2) { create(:company) }
  let!(:membership) { create(:company_membership, user: user, company: company) }

  before { login_user user }

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with :success }
  end

  describe '#GET show' do
    before { get :show, id: company }

    it { is_expected.to render_template(:show) }
    it { expect(assigns(:company)).to eq(company) }

  end

  describe '#PATCH join' do

    context 'with valid params' do
      before { patch :join, id: company_2 }

      it { expect(assigns(:membership)).to be_persisted }
      it { is_expected.to redirect_to(company_path(company_2)) }
      it { expect(flash[:notice]).to eq 'You have joined the company' }
    end

    context 'with existing membership' do
      before { patch :join, id: company }

      it { expect(assigns(:membership)).not_to be_a_new CompanyMembership }
      it { is_expected.to redirect_to(company_path(company)) }
      it { expect(flash[:alert]).to eq 'You already joined the company' }
    end
  end

  describe '#PATCH leave' do
    context 'with valid params' do
      before { patch :leave, id: company }

      it { expect(assigns(:membership)).to be_destroyed }
      it { is_expected.to redirect_to(company_path(company)) }
      it { expect(flash[:notice]).to eq 'You have left the company' }
    end

    context 'without existing membership' do
      before { patch :leave, id: company_2 }

      it { expect(assigns(:membership)).not_to be_persisted }
      it { is_expected.to redirect_to(company_path(company_2)) }
      it { expect(flash[:alert]).to eq 'You are not a member of the company' }
    end
  end

end
