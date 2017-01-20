require 'rails_helper'

RSpec.describe My::InvitesController, type: :controller do
  let(:user) { create(:user) }

  before { login_user user }

  describe '#POST create' do
    before { post :create, email: 'artist@somewhere.com' }

    it { is_expected.to redirect_to(root_path) }
    it { expect(ActionMailer::Base.deliveries).not_to be_empty }
  end
end
