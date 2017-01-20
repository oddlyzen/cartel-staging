require 'rails_helper'

RSpec.describe LanguageProficiency, type: :model do

  it { should belong_to(:profile).touch(true) }
  it { should belong_to(:language) }

  describe 'validations' do
    it { should validate_presence_of(:profile) }
    it { should validate_presence_of(:language) }
    it { should validate_presence_of(:level) }

    context 'for language scoped on profile' do
      subject { create(:language_proficiency) }
      it { should validate_uniqueness_of(:language).scoped_to(:profile_id) }
    end
  end

end
