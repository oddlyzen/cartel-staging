require 'rails_helper'

RSpec.describe ExperienceDecorator, type: :decorator do

  let(:experience) { create(:experience) }

  subject { described_class.new(experience) }

  describe '#company_location' do
    context 'when company and state present' do
      it { expect(subject.company_location).to eq("#{experience.company.name}, #{experience.state}") }
    end

    context 'when state is blank' do
      let(:experience) { create(:experience, state: nil) }

      it { expect(subject.company_location).to eq(experience.company.name) }
    end
  end

  describe '#full_position' do
    context 'when position and category present' do
      it { expect(subject.full_position).to eq("#{experience.position}, #{experience.category.capitalize}") }
    end

    context 'when category is blank' do
      let(:experience) { create(:experience, category: nil) }

      it { expect(subject.full_position).to eq(experience.position) }
    end
  end

end
