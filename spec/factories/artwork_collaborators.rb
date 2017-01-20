FactoryGirl.define do
  factory :artwork_collaborator do
    status :pending

    artwork
    association :collaborator, factory: [:user, :artist]
  end
end
