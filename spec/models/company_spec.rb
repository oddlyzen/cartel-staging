require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of(:image_url).on(:update) }

  it { should have_many(:members) }

  it { should belong_to(:owner).with_foreign_key('owner_id') }

  describe '#active?' do
    subject { build(:company, owner: owner) }

    context 'with owner' do
      let(:owner) { build(:user) }
      it { expect(subject.active?).to be_truthy }
    end

    context 'without owner' do
      let(:owner) { nil }
      it { expect(subject.active?).to be_falsey }
    end
  end

  describe '#pending?' do
    subject { build(:company, owner: owner) }

    context 'with owner' do
      let(:owner) { build(:user) }
      it { expect(subject.pending?).to be_falsey }
    end

    context 'without owner' do
      let(:owner) { nil }
      it { expect(subject.pending?).to be_truthy }
    end
  end

end
