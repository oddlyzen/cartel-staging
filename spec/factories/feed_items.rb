FactoryGirl.define do
  factory :feed_item do
    user
    kind :user_update

    trait :new_series_artwork do
      kind :new_series_artwork
      artwork
    end

    trait :series_published do
      kind :series_published
      association :resource, factory: :series
    end

    trait :user_update do
      kind :user_update
    end

    trait :invalid do
      user nil
      kind nil
    end

  end
end
