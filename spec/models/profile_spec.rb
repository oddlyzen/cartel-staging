require 'rails_helper'

RSpec.describe Profile, type: :model do

  it { should belong_to(:user).touch(true) }
  it { should have_many(:language_proficiencies) }
  it { should have_many(:languages).through(:language_proficiencies) }

end
