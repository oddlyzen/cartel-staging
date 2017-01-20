require 'rails_helper'

RSpec.describe OrganisationsController, type: :controller do

  let(:user) { create(:user) }
  let!(:company) { create(:company, owner: user) }

  before { login_user(user) }

  describe '#GET index' do
    before { get :index, artist_id: user.id }

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with :success }
    it { expect(assigns(:companies)).to include company }

  end
end
