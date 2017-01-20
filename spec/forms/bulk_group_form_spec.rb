require 'rails_helper'

RSpec.describe BulkGroupForm, type: :form do
  let(:owner) { create(:user, :artist) }
  let(:series) { create(:series, user: owner) }
  let(:artwork) { create(:artwork, series: nil, creator: owner) }
  let(:artwork_2) { create(:artwork, series: nil, creator: owner) }

  subject(:bulk_group_form) { described_class.new(artwork_ids: artwork_ids, series: series_id, user_id: owner_id) }

  describe '#save' do
    context 'with valid params and unpublished series' do
      let(:artwork_ids) { [artwork.id, artwork_2.id] }
      let(:series_id) { series.id }
      let(:owner_id) { owner.id }

      it { expect(bulk_group_form.save).to be_truthy }
      it 'should group artworks' do
        bulk_group_form.save

        aggregate_failures do
          expect(artwork.reload.series_id).to eq(series_id)
          expect(artwork_2.reload.series_id).to eq(series_id)
          expect(FeedItem.count).to eq(0)
        end
      end
    end

    context 'with valid params and published series' do
      let(:artwork_ids) { [artwork.id, artwork_2.id] }
      let(:series_id) { series.publish!; series.id }
      let(:owner_id) { owner.id }

      it { expect(bulk_group_form.save).to be_truthy }
      it 'should group artworks' do
        bulk_group_form.save

        aggregate_failures do
          expect(FeedItem.count).to eq(2)
        end
      end
      context 'cover photo' do
        it 'should update cover photo of series' do
          bulk_group_form.save
          expect(series.reload.artwork).to eq(artwork)
        end

        it 'should not update cover photo of series with cover photo' do
          series.update(artwork_id: artwork_2.id)
          bulk_group_form.save
          expect(series.reload.artwork).not_to eq(artwork)
        end
      end

    end

    context 'with invalid params' do
      let(:artwork_ids) {}
      let(:series_id) { series.id }
      let(:owner_id) { owner.id }

      it { expect(bulk_group_form.save).to be_falsey }
      it 'should not group artworks' do
        bulk_group_form.save

        aggregate_failures do
          expect(artwork.series_id).not_to eq(series_id)
          expect(artwork_2.series_id).not_to eq(series_id)
        end
      end
    end
  end
end
