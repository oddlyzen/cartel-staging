require 'rails_helper'

RSpec.describe Artwork, type: :model do

  it { should belong_to(:user) }

  it { should validate_presence_of :image_url }

  it { is_expected.to have_many(:feed_items).dependent(:destroy) }

  it { should validate_presence_of(:year).on(:series_save) }
  it { should validate_presence_of(:month).on(:series_save) }
  it { should validate_presence_of(:length).on(:series_save) }
  it { should validate_presence_of(:height).on(:series_save) }
  it { should validate_presence_of(:width).on(:series_save) }
  it { should validate_presence_of(:title).on(:series_save) }
  it { should validate_presence_of(:unit).on(:series_save) }

  describe 'custom validation' do

    context 'non context validation' do
      subject { create(:artwork, :invalid_subject) }

      it { expect(subject.valid?).to be_truthy }
    end

    context 'validate has_atleast_one_subject' do
      subject { create(:artwork, :invalid_subject) }

      it { expect(subject.valid?(:series_save)).to be_falsey }
    end

    context 'validate has_atleast_one_medium' do
      subject { create(:artwork, :invalid_medium) }

      it { expect(subject.valid?(:series_save)).to be_falsey }
    end
  end

end
