require 'rails_helper'

RSpec.describe CompanyDecorator, type: :decorator do

  let(:company) { build(:company) }

  subject { described_class.new(company) }

  describe '#opening_hours' do
    context 'with opening and closing times' do
      it do
        expect(subject.opening_hours).to eq(
          "#{company.opening_time.strftime('%H:%M')} - #{company.closing_time.strftime('%H:%M')}"
        )
      end
    end

    context 'without opening and closing times' do
      let(:company) { build(:company, opening_time: nil, closing_time: nil) }
      it { expect(subject.opening_hours).to be_nil }
    end
  end

end
