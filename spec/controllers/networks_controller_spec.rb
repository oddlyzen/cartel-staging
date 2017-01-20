require 'rails_helper'

RSpec.describe NetworksController, type: :controller do

  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let!(:connection) { create(:connection, :accepted, user: user, friend: friend) }

  before { login_user(user) }

  describe '#GET index' do
    before { get :index, artist_id: user.id }

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with :success }
    it { expect(assigns(:friends)).to include friend }

  end
end
