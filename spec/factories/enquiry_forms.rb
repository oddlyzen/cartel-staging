FactoryGirl.define do
  factory :enquiry_form do
    name 'Mr John'
    email 'email@pan.com'
    vocation 'Artist'
    subject 'How to register?'
    message 'I want to be a part of CARTEL community'

    trait :invalid do
      name ''
      email ''
      vocation ''
      subject ''
      message ''
    end
  end
end
