FactoryBot.define do
  factory :award do
    title 'Award title'
    month 10
    year 1990
    awarding_body 'Award Agent'
    prize 'Art Prize'
  end

  trait :invalid do
    title ''
    year nil
  end

end
