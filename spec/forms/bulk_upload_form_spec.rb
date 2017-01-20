require 'rails_helper'

RSpec.describe BulkUploadForm, type: :form do
  let(:user) { create(:user) }
  let(:links) { 'www.pic.com,www.pic2.com' }

  subject(:bulk_upload_form) do
    described_class.new(
      image_urls: links,
      user_id: user.id
    )
  end

  describe '#save' do
    context 'when uploaded successfully' do

      it 'returns true' do
        expect(bulk_upload_form.save).to be_truthy
      end

      it 'creates new artworks' do
        expect { bulk_upload_form.save }.to change(Artwork, :count).by(2)
      end
    end

    context 'when upload failed' do

      before do
        allow_any_instance_of(Artwork).to receive(:save!).with(validate: false) do
          raise ActiveRecord::RecordInvalid, Artwork.new
        end
      end

      it 'returns false' do
        expect(bulk_upload_form.save).to be_falsey
      end

      it 'creates new artworks' do
        expect { bulk_upload_form.save }.to change(Artwork, :count).by(0)
      end
    end
  end
end
