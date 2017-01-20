require 'rails_helper'

RSpec.describe UserHelper, type: :helper do

  describe '#university_location' do
    let(:education_record) { create(:education) }
    it { expect(university_location(education_record)).to eq "#{education_record.state}, #{education_record.country}" }
  end

end
