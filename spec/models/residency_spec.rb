require 'rails_helper'

RSpec.describe Residency, type: :model do

  it { is_expected.to belong_to(:user).touch(true) }

  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
    it { is_expected.to validate_presence_of :start_month }
    it { is_expected.to validate_presence_of :start_year }

    context 'when current field is false' do
      it { is_expected.to validate_presence_of :end_month }
      it { is_expected.to validate_presence_of :end_year }
    end

    context 'when current field is true' do
      subject { build(:residency, current: true) }

      it { is_expected.not_to validate_presence_of :end_month }
      it { is_expected.not_to validate_presence_of :end_year }
    end
  end

end
