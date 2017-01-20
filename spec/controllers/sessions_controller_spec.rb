require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:user) { create(:user, password: '123123123', password_confirmation: '123123123') }
  let(:user_inactive) do
    create(:user, email: 'inactive@mail.com',
                  password: '123123123', password_confirmation: '123123123', active: false)
  end

  describe 'GET #new' do

    before { get :new }

    it { is_expected.to render_template(:new) }
    it { is_expected.to respond_with :success }

  end

  describe 'POST #create' do

    context 'with valid credentials' do

      before { post :create, login_form: { email: user.email, password: '123123123' } }

      it { expect(controller.current_user).not_to be_nil }
      it { is_expected.to redirect_to(my_feed_path) }

    end

    context 'with invalid credentials' do

      before { post :create, login_form: { email: 'abc@mail.com', password: '0123456' } }

      it { expect(controller.current_user).to be_nil }
      it { is_expected.to render_template(:new) }

    end

    context 'with inactive status' do
      before { post :create, login_form: { email: 'inactive@mail.com', password: '0123456' } }

      it { expect(controller.current_user).to be_nil }
      it { is_expected.to render_template(:new) }
    end

  end

  describe 'DELETE #destroy' do

    let!(:user) { create(:user) }

    before do
      login_user(user)
      delete :destroy
    end

    it { is_expected.to redirect_to(root_path) }

  end

end
