FactoryGirl.define do
  factory :connection do
    status :pending
    user
    association :friend, factory: :user

    trait :accepted do
      status :accepted
    end

    trait :rejected do
      status :rejected
    end

    trait :invalid do
      user_id nil
      friend_id nil
    end
  end
end
