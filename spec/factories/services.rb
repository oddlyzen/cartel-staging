FactoryGirl.define do
  factory :service do
    sequence :name do |n|
      "Tag_#{n}"
    end
    state :approved

    trait :invalid do
      name ''
    end
  end
end
