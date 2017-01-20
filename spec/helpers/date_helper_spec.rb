require 'rails_helper'

RSpec.describe DateHelper, type: :helper do

  describe '#single_date' do
    context 'with month and year' do
      let(:award) { build(:award, month: 1, year: 1990) }

      it { expect(single_date(award)).to eq 'Jan 1990' }
    end

    context 'without month and only year' do
      let(:award) { build(:award, month: nil, year: 1990) }

      it { expect(single_date(award)).to eq '1990' }
    end
  end

  describe '#date_in_range' do
    context 'with presence of start_month and end_month' do
      context 'without current value' do
        let(:residency) { build(:residency) }

        it { expect(date_in_range(residency)).to eq 'Jan 1990 - Dec 1994' }
      end

      context 'with current value' do
        let(:residency) { build(:residency, current: true) }

        it { expect(date_in_range(residency)).to eq 'Jan 1990 - Present' }
      end
    end

    context 'without month and year' do
      let(:residency) { build(:residency, :no_duration) }

      it { expect(date_in_range(residency)).to eq '-' }
    end

    context 'without end month and year' do
      context 'without current value' do
        let(:residency) { build(:residency, :no_end_duration) }

        it { expect(date_in_range(residency)).to eq 'Jan 1990 -  ' }
      end
      context 'with current value' do
        let(:residency) { build(:residency, :no_end_duration_and_current) }

        it { expect(date_in_range(residency)).to eq 'Jan 1990 - Present' }
      end
    end
  end

end
