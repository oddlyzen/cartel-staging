require 'rails_helper'

RSpec.describe Language, type: :model do

  it { should belong_to(:user) }
  it { should have_many(:language_proficiencies) }
  it { should have_many(:profiles).through(:language_proficiencies) }

  it { should validate_presence_of(:name) }

end
