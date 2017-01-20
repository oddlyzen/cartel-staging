require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  describe 'POST #interest' do
    context 'with valid params' do
      before do
        ActionMailer::Base.deliveries = []
        post :interest, interest_form: attributes_for(:interest_form)
      end

      it { is_expected.to redirect_to root_path }
      it { expect(ActionMailer::Base.deliveries).not_to be_empty }
    end

    context 'with invalid params' do
      before do
        ActionMailer::Base.deliveries = []
        post :interest, interest_form: attributes_for(:interest_form, :invalid)
      end

      it { is_expected.to redirect_to about_path }
      it { expect(ActionMailer::Base.deliveries).to be_empty }
    end
  end

  describe 'POST #enquiry' do
    context 'with valid params' do
      before do
        ActionMailer::Base.deliveries = []
        post :enquiry, enquiry_form: attributes_for(:enquiry_form)
      end

      it { is_expected.to redirect_to root_path }
      it { expect(ActionMailer::Base.deliveries).not_to be_empty }
    end

    context 'with invalid params' do
      before do
        ActionMailer::Base.deliveries = []
        post :enquiry, enquiry_form: attributes_for(:enquiry_form, :invalid)
      end

      it { is_expected.to redirect_to contact_us_path }
      it { expect(ActionMailer::Base.deliveries).to be_empty }
    end
  end
end
