require 'rails_helper'

RSpec.describe CompanyMembership, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:company) }

  it { should validate_presence_of(:user_id) }
end
