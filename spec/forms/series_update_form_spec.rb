require 'rails_helper'

RSpec.describe SeriesUpdateForm, type: :form do

  let(:user) { create(:user) }
  let(:series) { create(:series, user: user) }
  let(:series_attributes) { attributes_for(:series) }
  let(:exhibition_attributes) { attributes_for(:exhibition) }

  let(:form_params) do
    {
      id: series.id,
      user_id: user.id,
      series_attributes: series_attributes,
      exhibition_attributes: exhibition_attributes
    }
  end

  subject(:series_update_form) { described_class.new(form_params) }

  describe '#save' do
    context 'with valid params' do
      it 'returns true' do
        expect(series_update_form.save).to be_truthy
      end

      context 'with exhibition_attributes' do
        it 'persists new exhibition' do
          series_update_form.save
          expect(series_update_form.exhibition).to be_persisted
        end
      end

      context 'without exhibition_attributes' do
        let(:exhibition_attributes) { {} }
        it 'should not persist new exhibition' do
          series_update_form.save
          expect(series_update_form.exhibition).not_to be_persisted
        end
      end
    end

    context 'with invalid params' do

      context 'with invalid series params' do
        let(:series_attributes) { attributes_for(:series, :invalid) }

        it { expect(series_update_form.save).to be_falsey }
      end

      context 'with invalid exhibition params' do
        let(:exhibition_attributes) { attributes_for(:exhibition, :invalid) }

        it { expect(series_update_form.save).to be_falsey }
      end

    end
  end

  describe '#publish' do
    context 'with valid params' do
      it 'returns true' do
        expect(series_update_form.publish).to be_truthy
      end
      context 'with valid artworks' do
        before { create(:artwork, series: series) }
        it 'returns true' do
          expect(series_update_form.publish).to be_truthy
        end
      end
      it 'creates feeditems' do
        expect { series_update_form.publish }.to change(FeedItem, :count).by(1)
      end
      it 'publish the series' do
        series_update_form.publish
        series.reload
        expect(series.published?).to be_truthy
      end
    end

    context 'with invalid params' do
      context 'with invalid series' do
        let(:series_attributes) { attributes_for(:series, :invalid_for_publish) }
        it 'returns false' do
          expect(series_update_form.publish).to be_falsey
        end
        it 'does not publish the series' do
          series_update_form.publish
          series.reload
          expect(series.published?).to be_falsey
        end
        it 'does notcreate feeditems' do
          expect { series_update_form.publish }.to change(FeedItem, :count).by(0)
        end
      end
    end

  end

end
