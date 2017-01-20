require 'rails_helper'

RSpec.describe ArtworkArrangementForm, type: :form do
  let!(:series) { create(:series) }
  let(:artwork) { create(:artwork, series: series) }
  let(:artwork_2) { create(:artwork, series: series) }

  subject(:valid_artwork_arrangement_form) do
    described_class.new(
      artworks_order: "#{artwork.id},#{artwork_2.id}",
      series_id: series.id
    )
  end

  subject(:invalid_artwork_arrangement_form) do
    described_class.new(
      series_id: series.id
    )
  end

  describe '#save' do
    context 'when rearrangement succeed' do
      it 'returns true' do
        expect(valid_artwork_arrangement_form.save).to be_truthy
      end
    end

    context 'when rearrangement failed' do
      it 'returns false' do
        expect(invalid_artwork_arrangement_form.save).to be_falsey
      end
    end
  end
end
