require 'rails_helper'

RSpec.describe ExhibitionDecorator, type: :decorator do

  let(:exhibition) { build(:exhibition) }
  let(:venue) { exhibition.venue }

  subject { described_class.new(exhibition) }

  describe '#title' do
    context 'with title' do
      it { expect(subject.title).to eq(exhibition.title) }
    end

    context 'without title' do
      let(:exhibition) { build(:exhibition, title: nil) }
      it { expect(subject.title).to eq('Title not available') }
    end
  end

  describe '#location' do
    context 'with venue and country present' do
      it { expect(subject.location).to eq("#{venue.name}, #{exhibition.country}") }
    end

    context 'without venue and country present' do
      let(:exhibition) { build(:exhibition, venue: nil, country: nil) }
      it { expect(subject.location).to eq('Location not available') }
    end
  end

  describe '#start_date' do
    context 'with exhibition start date' do
      it { expect(subject.start_year).to eq(exhibition.start_year) }
    end

    context 'without exhibition start date' do
      let(:exhibition) { build(:exhibition, start_year: nil) }
      it { expect(subject.start_year).to eq('Year started not available') }
    end
  end

end
