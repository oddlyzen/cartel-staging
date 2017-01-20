require 'rails_helper'

RSpec.describe My::CompanyForm, type: :form do

  let(:company_params) { attributes_for(:company) }
  let(:existing_company) { nil }
  let(:form_params) do
    {
      company_attributes: company_params,
      existing_company: existing_company
    }
  end

  subject do
    described_class.new(form_params)
  end

  describe '#save' do
    context 'without existing company' do
      context 'with valid params' do
        it { expect(subject.save).to be_truthy }
        it do
          subject.save
          expect(subject.company).to be_persisted
        end
      end

      context 'with invalid params' do
        let(:company_params) { attributes_for(:company, :invalid) }

        it { expect(subject.save).to be_falsey }
        it do
          subject.save
          expect(subject.company).not_to be_persisted
        end
      end
    end

    context 'with existing company' do
      let(:existing_company) { create(:company, name: 'Galleria') }

      context 'with valid params' do
        it { expect(subject.save).to be_truthy }
        it do
          subject.save
          expect(subject.company.name).to eq company_params[:name]
        end
      end

      context 'with invalid params' do
        let(:company_params) { attributes_for(:company, :invalid) }

        it { expect(subject.save).to be_falsey }
        it do
          subject.save
          expect(subject.company).to be_changed
        end
      end
    end
  end

end
