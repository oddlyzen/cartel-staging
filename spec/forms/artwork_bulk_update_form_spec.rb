require 'rails_helper'

RSpec.describe ArtworkBulkUpdateForm, type: :form do
  let(:series) { create(:series) }
  let(:published_series) { s = create(:series); s.publish!; s }
  let!(:unpublished_series) { create(:series) }
  let(:artwork) { create(:artwork, series: series) }
  let(:artwork_2) { create(:artwork, series: series) }
  let!(:artwork_with_invalid_medium) { create(:artwork, :invalid_medium, series: series) }

  let(:form_params) { { ids: "#{artwork.id}, #{artwork_2.id}", series_id: series.id } }

  subject { described_class.new(form_params) }

  describe '#save' do
    context 'when ids not blank' do

      before { subject.save }

      it { is_expected.to be_truthy }

      context 'when change the valid artworks to published series' do

        let(:form_params) { { ids: artwork.id.to_s, series_id: published_series.id } }

        it { is_expected.to be_truthy }

        it 'changes the series' do
          artwork.reload
          expect(artwork.series).to eq(published_series)
        end

      end

      context 'when change the invalid artworks to published series' do

        let(:form_params) { { ids: artwork_with_invalid_medium.id.to_s, series_id: published_series.id } }

        it { is_expected.to be_truthy }

        it 'does changes the series' do
          artwork_with_invalid_medium.reload
          expect(artwork_with_invalid_medium.series).not_to eq(published_series)
        end

      end

      context 'when change the valid artworks to unpublished series' do
        let(:form_params) { { ids: artwork.id.to_s, series_id: unpublished_series.id } }

        it { is_expected.to be_truthy }

        it 'changes the series' do
          artwork.reload
          expect(artwork.series).to eq(unpublished_series)
        end
      end

      context 'when change the invalid artworks to unpublished series' do

        let(:form_params) { { ids: artwork_with_invalid_medium.id.to_s, series_id: unpublished_series.id } }

        it { is_expected.to be_truthy }

        it 'does changes the series' do
          expect(artwork_with_invalid_medium.series).to eq(series)
        end

      end

    end

    context 'when ids blank' do
      let(:form_params) { { ids: '', series_id: published_series.id } }
      it 'returns false' do
        expect(subject.save).to be_falsey
      end
    end
  end
end
