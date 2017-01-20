require 'rails_helper'

RSpec.describe EnquiryForm, type: :form do
  subject(:enquiry_form) do
    described_class.new(enquiry_params)
  end

  describe '#valid?' do
    context 'with valid params' do
      let(:enquiry_params) { attributes_for(:enquiry_form) }

      it { expect(enquiry_form.valid?).to eq true }
    end

    context 'with invalid params' do
      let(:enquiry_params) { attributes_for(:enquiry_form, :invalid) }

      it { expect(enquiry_form.valid?).to eq false }
    end
  end
end
