require 'rails_helper'

RSpec.describe Admin::CompaniesController, type: :controller do

  let(:admin_user) { create(:user, :admin) }
  let(:company) { create(:company) }

  before { login_user admin_user }

  describe '#GET index' do

    before { get :index }

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with :success }

  end

  describe 'GET #edit' do

    before { get :edit, id: company }

    it { is_expected.to render_template(:edit) }
    it { expect(assigns(:company)).to eq(company) }

  end

  describe 'PUT #update' do

    context 'with valid params' do

      before { put :update, id: company, company: attributes_for(:company) }

      it { is_expected.to redirect_to(admin_companies_path) }

    end

    context 'with invalid params' do

      before { put :update, id: company, company: attributes_for(:company, :invalid) }

      it { is_expected.to render_template(:edit) }
    end

  end

end
