FactoryBot.define do
  factory :artwork do
    image_url '/spec/fixtures/files/artpiece1.jpeg'
    title 'The Starry Night'
    height 74
    width 92
    length 20
    unit :cm
    year 1983
    month 6
    art_type 'Oil on canvas'
    description 'The Starry Night is an oil on canvas by the Dutch post-impressionist painter Vincent van Gogh.'
    subject_ids %w(1 2)
    medium_ids %w(1 2)

    association :user, factory: :user, strategy: :build
    association :series, factory: :series, strategy: :build

    trait :invalid do
      image_url ''
    end

    trait :invalid_subject do
      subject_ids []
    end

    trait :invalid_medium do
      medium_ids []
    end
  end
end
