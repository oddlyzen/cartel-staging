require 'rails_helper'

RSpec.describe ContactMailer, type: :mailer do

  let!(:admin) { create(:user, :admin) }

  describe '#interest' do
    interest_params = { email: 'curious@user.com', name: 'Curious', title: 'Prof', interest: 'Painting' }

    subject { @email = ContactMailer.interest(interest_params) }

    it { is_expected.to deliver_from('curious@user.com') }
    it { is_expected.to deliver_to(admin.email) }
    it { is_expected.to have_subject(/[Interest Form]/) }
    it { is_expected.to have_body_text(/This is my area of interest/) }
  end

  describe '#enquiry' do
    enquiry_params = { email: 'confused@user.com', name: 'Confused', title: 'Prof',
                       subject: 'Career in PAN', message: 'I want to teach arts', vocation: 'Art Educator' }

    subject { @email = ContactMailer.enquiry(enquiry_params) }

    it { is_expected.to deliver_from('confused@user.com') }
    it { is_expected.to deliver_to(admin.email) }
    it { is_expected.to have_subject(/[Enquiry Form]/) }
    it { is_expected.to have_body_text(/This is what I do/) }
  end

end
