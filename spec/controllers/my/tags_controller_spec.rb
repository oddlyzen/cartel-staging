require 'rails_helper'

RSpec.describe My::TagsController, type: :controller do

  let(:user) { create(:user) }

  before { login_user user }

  describe '#POST create' do
    context 'with valid tag' do
      it do
        create_valid_tag
        result = JSON.parse(response.body)
        expect(result['name']).to eq('New Tag')
      end

      it { expect { create_valid_tag }.to change(Medium, :count).by(1) }
    end

    context 'with invalid tag' do
      it { create_invalid_tag; expect(response).to redirect_to root_path }
      it { expect { create_invalid_tag }.not_to change(Medium, :count) }
    end

    context 'with invalid params' do
      it { create_invalid_params; expect(response).to redirect_to root_path }
      it { expect { create_invalid_params }.not_to change(Medium, :count) }
    end
  end

  private

  def create_valid_tag
    post :create, name: 'New Tag', klass: 'Medium', format: :json
  end

  def create_invalid_tag
    post :create, name: 'New Tag', klass: 'Food', format: :json
  end

  def create_invalid_params
    post :create, name: '', klass: 'Subject', format: :json
  end

end
