require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe 'GET #new' do
    before { get :new }

    it { is_expected.to render_template(:new) }
    it { is_expected.to respond_with :success }
  end

  describe 'POST #create' do
    context 'with valid params' do
      before do
        post :create, registration_form: attributes_for(:user, password: '123123123',
                                                               password_confirmation: '123123123'), format: 'js'
      end

      it { expect(response).to be_success }
    end

    context 'with invalid params' do
      before { post :create, registration_form: attributes_for(:user), format: 'js' }

      it { expect(flash[:error].to_s) }
      it { expect(controller.current_user).to be_nil }
    end
  end

end
