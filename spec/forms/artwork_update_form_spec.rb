require 'rails_helper'

RSpec.describe ArtworkUpdateForm, type: :form do
  let(:series) { create(:series) }
  let(:artist) { create(:user, :artist) }
  let(:collaborator) { create(:user, :artist) }
  let(:collaborator_2) { create(:user, :artist) }
  let!(:artwork) { create(:artwork, series: series, user: artist) }

  subject(:artwork_update_form) do
    described_class.new(params)
  end

  describe '#save' do
    context 'when updated successfully' do
      let(:params) do
        attributes_for(:artwork).merge(
          user_id: artist.id,
          id: artwork.id,
          collaborator_ids: [collaborator.id.to_s, collaborator_2.id.to_s]
        )
      end

      it 'returns true' do
        expect(artwork_update_form.save).to be_truthy
      end
    end

    context 'when update failed' do
      let(:params) do
        attributes_for(:artwork, :invalid).merge(
          user_id: artist.id,
          id: artwork.id
        )
      end

      it 'returns false' do
        expect(artwork_update_form.save).to be_falsey
      end
    end
  end
end
