require 'rails_helper'

RSpec.describe LocationsController, type: :controller do

  describe '#GET show' do
    before { get :show, id: 'Malaysia' }

    it do
      result = JSON.parse(response.body)
      expect(result.first).to eq('Johor')
    end
  end
end
