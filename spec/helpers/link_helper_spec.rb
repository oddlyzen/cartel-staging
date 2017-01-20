require 'rails_helper'

RSpec.describe LinkHelper, type: :helper do
  let(:artist) { create(:user, :artist) }
  let(:professional) { create(:user, :professional) }

  describe '#active' do
    let(:controller_name) { 'artists' }
    let(:action_name) { 'show' }

    before do
      allow(ActionController::Base).to receive(:controller_name).and_return(controller_name)
      allow_any_instance_of(ActionController::Base).to receive(:action_name).and_return(action_name)
    end

    it 'returns active' do
      expect(helper.active(:profile)).to eq 'is-active'
    end
  end

  describe '#profile_path' do
    context 'user is an artist' do
      it 'returns artist#show' do
        expect(helper.profile_path(artist)).to eq artist_path(artist)
      end
    end

    context 'user is a professional' do
      it 'returns professional#show' do
        expect(helper.profile_path(professional)).to eq professional_path(professional)
      end
    end
  end

  describe '#pages_path' do
    context 'current user viewing' do
      before do
        allow(controller).to receive(:current_user).and_return(artist)
      end

      it 'returns my-companies-path' do
        expect(helper.pages_path(artist)).to eq my_companies_path
      end
    end

    context 'other user viewing' do
      before do
        allow(controller).to receive(:current_user).and_return(nil)
      end

      context 'and user is an artist' do
        it 'returns artist-companies' do
          expect(helper.pages_path(artist)).to eq artist_organisations_path(artist)
        end
      end

      context 'and user is a professional' do
        it 'returns professional-companies' do
          expect(helper.pages_path(professional)).to eq professional_organisations_path(professional)
        end
      end

    end
  end
end
