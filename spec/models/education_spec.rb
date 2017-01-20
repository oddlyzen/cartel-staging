require 'rails_helper'

RSpec.describe Education, type: :model do

  it { should belong_to(:user).touch(true) }

  it { should validate_presence_of(:institution) }
  it { should validate_presence_of(:start_year) }
  it { should validate_presence_of(:end_year) }
  it { should validate_presence_of(:country) }

end
