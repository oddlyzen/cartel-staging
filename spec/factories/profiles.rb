FactoryGirl.define do
  factory :profile do
    skill_ids [1, 2]
    subject_ids [1, 2]
    medium_ids [1, 2]
    specialisation_ids [1, 2]
    interest_ids [1, 2]
    service_ids [1, 2]

    trait :empty do
      skill_ids []
      subject_ids []
      medium_ids []
      specialisation_ids []
      interest_ids []
      language_ids []
      service_ids []
    end
  end
end
