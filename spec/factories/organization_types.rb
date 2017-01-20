FactoryGirl.define do
  factory :organization_type do
    name 'Startup'
    state :approved
    public_option true
  end
end
