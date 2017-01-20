FactoryGirl.define do
  factory :medium do
    sequence :name do |n|
      "Tag_#{n}"
    end
    state :approved
    set_display true

    trait :invalid do
      name ''
    end
  end
end
