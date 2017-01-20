require 'rails_helper'

RSpec.describe Experience, type: :model do

  it { should belong_to(:user).touch(true) }
  it { should belong_to(:company) }

  it { should validate_presence_of(:position).on(:update) }
  it { should validate_presence_of(:start_year).on(:update) }
  it { should validate_presence_of(:start_month).on(:update) }

end
