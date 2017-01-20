require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  subject { UserMailer.reset_password_email(user) }

  describe 'reset_password_email' do
    it { is_expected.to deliver_to(user.email) }
    it { is_expected.to have_subject(/Reset password email/) }
  end

end
