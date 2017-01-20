require 'rails_helper'

RSpec.describe Exhibition, type: :model do

  it { is_expected.to belong_to(:user).touch(true) }
  it { is_expected.to belong_to(:venue) }
  it { is_expected.to belong_to(:representation) }

  it { is_expected.to have_many(:series) }

  describe 'validations' do
    context 'with pdf attachment' do
      subject { build(:exhibition, :with_attachment) }

      it { is_expected.not_to validate_presence_of(:title) }
    end

    context 'without pdf attachment' do
      it { is_expected.to validate_presence_of(:title) }
    end

    context 'with title' do
      subject { build(:exhibition, :with_title) }

      it { is_expected.not_to validate_presence_of(:pdf_url) }
    end

    context 'without title' do
      it { is_expected.to validate_presence_of(:pdf_url) }
    end
  end

end
