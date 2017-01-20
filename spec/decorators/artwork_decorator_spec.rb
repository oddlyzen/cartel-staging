require 'rails_helper'

RSpec.describe ArtworkDecorator, type: :decorator do

  let(:artwork) { build(:artwork) }

  subject { described_class.new(artwork) }

  describe '#creator_name' do
    it { expect(subject.creator_name).to eq("#{artwork.user.first_name} #{artwork.user.last_name}") }
  end

  describe '#description_snippet' do
    context 'description is available' do
      it { expect(subject.description_snippet).to eq(artwork.description) }
    end

    context 'withoud description' do
      let(:artwork) { build(:artwork, description: nil) }
      it { expect(subject.description_snippet).to eq('Description not available') }
    end
  end

  describe '#title' do
    context 'with title' do
      it { expect(subject.title).to eq(artwork.title) }
    end

    context 'without title' do
      let(:artwork) { build(:artwork, title: nil) }

      it { expect(subject.title).to eq('Untitled') }
    end
  end

  describe 'exhibited_at' do
    it { expect(subject.exhibited_at).to eq "Exhibited at: #{artwork.series.exhibition.venue.name}" }
  end

  describe '#series_title' do
    it { expect(subject.series_title).to eq('Series: Deeply Twisted') }
  end

  describe '#dimension' do
    context 'when dimension is available' do
      it { expect(subject.dimension).to eq('74 x 92 cm') }
    end

    context 'when dimension is not available' do
      let(:artwork) { build(:artwork, height: nil, width: nil, unit: nil) }
      it { expect(subject.dimension).to eq('Dimension not available') }
    end
  end

  describe '#year' do
    context 'with year' do
      it { expect(subject.year).to eq(artwork.year) }
    end

    context 'without year' do
      let(:artwork) { build(:artwork, year: nil) }
      it { expect(subject.year).to eq('---') }
    end
  end

end
