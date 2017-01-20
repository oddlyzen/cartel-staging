require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do

  let(:admin_user) { create(:user, :admin) }

  before { login_user admin_user }

  describe '#GET index' do

    before { get :index }

    it { is_expected.to render_template(:index) }
    it { is_expected.to respond_with :success }

  end

end
