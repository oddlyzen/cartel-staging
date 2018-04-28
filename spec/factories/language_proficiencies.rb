FactoryBot.define do
  factory :language_proficiency do
    language
    profile
    level :Fluent

    trait :invalid do
      language nil
      profile nil
      level nil
    end
  end
end
