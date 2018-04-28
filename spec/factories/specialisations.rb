FactoryBot.define do
  factory :specialisation do
    sequence :name do |n|
      "Tag_#{n}"
    end
    state :approved

    trait :invalid do
      name ''
    end
  end
end
