require 'rails_helper'

RSpec.describe InterestForm, type: :form do
  subject(:interest_form) do
    described_class.new(interest_params)
  end

  describe '#valid?' do
    context 'with valid params' do
      let(:interest_params) { attributes_for(:interest_form) }

      it { expect(interest_form.valid?).to eq true }
    end

    context 'with invalid params' do
      let(:interest_params) { attributes_for(:interest_form, :invalid) }

      it { expect(interest_form.valid?).to eq false }
    end
  end
end
