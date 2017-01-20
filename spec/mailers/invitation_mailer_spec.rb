require 'rails_helper'

RSpec.describe InvitationMailer, type: :mailer do

  let!(:user) { create(:user, :artist) }

  let(:params) do
    {
      full_name: 'John Doe',
      email: 'user@example.com'
    }
  end

  subject { InvitationMailer.invite(params[:email], params[:full_name], user) }

  describe '#invite' do
    it { is_expected.to deliver_to(params[:email]) }
    it { is_expected.to have_subject('An Invitation to join Cartel') }
  end

end
