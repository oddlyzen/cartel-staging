FactoryBot.define do
  factory :skill do
    sequence :name do |n|
      "Tag_#{n}"
    end
    state :approved

    trait :invalid do
      name ''
    end
  end
end
