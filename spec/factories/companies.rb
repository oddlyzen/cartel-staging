FactoryBot.define do
  factory :company do
    sequence :name do |n|
      "company_#{n}"
    end

    sequence :email do |n|
      "company_#{n}@mail.com"
    end

    image_url '/app/assets/images/gallery_250x250.jpg'

    description 'Why this company is amazing'
    motto 'We love all arts'
    location 'Location'
    established_in 10.years.ago
    address_1 'Address Line 1'
    address_2 'Address Line 2'
    phone '+60196467320'
    about_us 'About Us'

    country 'Singapore'
    state 'Bugis'

    opening_time Time.zone.parse '09:00'
    closing_time Time.zone.parse '22:00'

    association :owner, factory: :user

    trait :invalid do
      name ''
      email '432'
      phone 'abcded'
    end
  end

end
