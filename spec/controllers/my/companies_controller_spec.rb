require 'rails_helper'

RSpec.describe My::CompaniesController, type: :controller do

  let(:user) { create(:user) }
  let(:company) { create(:company, owner: user) }

  before { login_user user }

  describe '#GET show' do

    before { get :show, id: company.id }

    it { is_expected.to render_template(:show) }
    it { expect(assigns(:company_presenter)).to be_a My::CompanyPresenter }

  end

  describe '#GET index' do

    before { get :index }

    it { is_expected.to render_template(:index) }
    it { expect(assigns(:user)).to eq(user) }

  end

  describe 'GET #new' do

    before { get :new }

    it { is_expected.to render_template(:new) }

    it { expect(assigns(:company_form)).to be_new_record }

  end

  describe 'POST #create' do

    context 'with valid params' do

      before do
        post :create, my_company_form: { company_attributes: attributes_for(:company, name: 'hello') }
      end

      it { expect(flash[:error]).to be_nil }
      it { is_expected.to redirect_to(my_companies_path) }

    end

    context 'with invalid params' do

      before do
        post :create, my_company_form: { company_attributes: attributes_for(:company, name: '') }
      end

      it { expect(flash[:error]).not_to be_nil }
      it { is_expected.to render_template(:new) }

    end

  end

  describe 'GET #edit' do

    before { get :edit, id: company }

    it { is_expected.to render_template(:edit) }
    it { expect(assigns(:company)).to eq(company) }

  end

  describe 'PUT #update' do

    context 'with valid params' do

      before do
        put :update, id: company, my_company_form: { company_attributes: attributes_for(:company) }
      end

      it { is_expected.to redirect_to(my_companies_path) }

    end

    context 'with invalid params' do

      before do
        put :update, id: company, my_company_form: { company_attributes: attributes_for(:company, :invalid) }
      end

      it { is_expected.to render_template(:edit) }
    end

  end

end
