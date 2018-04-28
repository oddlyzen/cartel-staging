FactoryBot.define do
  factory :institution do
    name 'NUS'

    trait :invalid do
      name nil
    end

  end
end
