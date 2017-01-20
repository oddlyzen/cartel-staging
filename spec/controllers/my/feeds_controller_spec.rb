require 'rails_helper'

RSpec.describe My::FeedsController, type: :controller do

  let(:user) { create(:user) }

  before { login_user user }

  describe '#GET show' do
    before { get :show }

    it { is_expected.to render_template(:show) }
    it { expect(assigns(:user)).to eq(user) }

  end

end
