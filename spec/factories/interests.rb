FactoryGirl.define do
  factory :interest do
    sequence :name do |n|
      "Tag_#{n}"
    end
    state :approved

    trait :invalid do
      name ''
    end
  end
end
