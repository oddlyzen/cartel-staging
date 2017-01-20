require 'rails_helper'

RSpec.describe ArtistsController, type: :controller do
  let(:user) { create(:user) }

  before { login_user user }

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with :success }
  end

  describe '#GET show' do

    before { get :show, id: user }

    it { is_expected.to render_template(:show) }

  end
end
