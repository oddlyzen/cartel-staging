FactoryGirl.define do
  factory :interest_form do
    name 'Mr John'
    email 'email@pan.com'
    title 'Prof'
    interest 'Painting'

    trait :invalid do
      name ''
      email ''
      title ''
      interest ''
    end
  end
end
