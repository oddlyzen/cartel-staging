require 'rails_helper'

RSpec.describe Bibliography, type: :model do

  it { is_expected.to belong_to(:user).touch(true) }

  describe 'validations' do
    context 'when pdf_url is blank' do
      subject { build(:bibliography) }

      it { is_expected.to validate_presence_of(:title) }
    end

    context 'when pdf_url is present' do
      subject { build(:bibliography, :with_pdf) }

      it { is_expected.not_to validate_presence_of(:title) }
    end
  end

end
