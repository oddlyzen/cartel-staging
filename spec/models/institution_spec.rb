require 'rails_helper'

RSpec.describe Institution, type: :model do

  subject { build(:institution) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

end
