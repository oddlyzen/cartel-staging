FactoryGirl.define do
  factory :company_membership do
    association :user
    association :company
    state :pending

    trait :invalid do
      user_id nil
    end
  end
end
