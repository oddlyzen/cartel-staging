require 'rails_helper'

RSpec.describe SeriesDecorator, type: :decorator do

  let(:series) { build(:series) }
  let(:subject) { described_class.new(series) }

  describe '#title' do
    context 'with title' do
      it { expect(subject.title).to eq(series.title) }
    end

    context 'without title' do
      let(:series) { build(:series, title: nil) }
      it { expect(subject.title).to eq('Untitled') }
    end
  end

  describe '#year' do
    context 'with year' do
      it { expect(subject.year).to eq(series.year.strftime('%Y')) }
    end

    context 'without year' do
      let(:series) { build(:series, year: nil) }

      it { expect(subject.year).to eq('---') }
    end
  end

  describe '#description' do
    context 'with description' do
      it { expect(subject.description).to eq(series.description) }
    end

    context 'without description' do
      let(:series) { build(:series, description: nil) }

      it { expect(subject.description).to eq('Description not available') }
    end
  end

end
