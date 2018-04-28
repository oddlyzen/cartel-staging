# FactoryBot.define do
#   factory :user do
#     sequence :email do |n|
#       "test_#{n}@mail.com"
#     end
#
#     referrer_id nil
#     password '123123123'
#     password_confirmation '123123123'
#     reset_password_token '123reset'
#     title 'mr'
#     first_name 'Ronald'
#     last_name 'Hunt'
#     role :artist
#     date_of_birth 20.years.ago
#     nationality_country 'Malaysia'
#     residency_status 'resident'
#     based_country 'Malaysia'
#     based_state 'johor'
#     current_status 'Seeking Representation'
#     artist_status_text []
#     professional_status_text []
#     commission true
#     media_tags []
#     subjects_tags []
#     specialisations_tags []
#     tagline 'Travel and discover'
#     representation 'Gallery Malaysia'
#     from_exhibit_date 10.years.ago
#     to_exhibit_date 9.years.ago
#     exhibit_title 'Title'
#     participation 'Group'
#     venue 'Kuala Lumpur'
#     exhibit_country 'Malaysia'
#     exhibit_state 'selangor'
#     link 'www.link.com'
#     from_record_year '2015-11-01'
#     to_record_year '2015-11-01'
#     acknowledgement 1
#     profile_image_url '/spec/fixtures/files/profile.png'
#
#     trait :empty do
#       commission false
#       representation ''
#       venue ''
#       link ''
#     end
#
#     trait :invalid do
#       email ''
#     end
#
#     trait :inactive do
#       active false
#     end
#
#     trait :admin do
#       email ENV['ADMIN_MAIL']
#       role :admin
#     end
#
#     trait :artist do
#       role :artist
#     end
#
#     trait :professional do
#       role :professional
#       current_status 'Works at'
#     end
#
#     trait :freelace_professional do
#       role :professional
#       current_status 'Freelance'
#     end
#
#     after(:build, &:create_profile)
#
#   end
# end
