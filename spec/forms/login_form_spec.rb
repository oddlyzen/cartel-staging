require 'rails_helper'

RSpec.describe LoginForm, type: :form do
  let(:password) { 'some_password' }
  let(:user) { create(:user, password: password, password_confirmation: password) }

  subject(:session_form) do
    described_class.new(form_params)
  end

  describe '#valid?' do
    context 'with correct email and password' do
      let(:form_params) do
        {
          email: user.email,
          password: password
        }
      end

      context 'and user is active' do
        it { expect(session_form).to be_valid }
      end

      context 'and user is inactive' do
        let(:user) { create(:user, :inactive, password: password, password_confirmation: password) }
        it { expect(session_form).not_to be_valid }
      end
    end

    context 'with wrong email' do
      let(:form_params) do
        {
          email: user.email + '_invalid',
          password: password
        }
      end

      it { expect(session_form).not_to be_valid }
    end

    context 'with wrong password' do
      let(:form_params) do
        {
          email: user.email,
          password: password + '_invalid'
        }
      end

      it { expect(session_form).not_to be_valid }
    end
  end

end
