# FactoryBot.define do
#   factory :experience do
#     association :user
#     association :company
#
#     company_name 'Tinkerbox'
#     position 'Software Developer'
#     country 'Singapore'
#     state 'Bishan'
#     link 'www.tinkerbox.com.sg'
#     category 1
#     job_type 1
#     description 'This is a great company'
#     start_month 2
#     start_year 2013
#     end_month 12
#     end_year 2104
#
#     trait :current do
#       current '1'
#     end
#
#     trait :invalid do
#       position nil
#       start_year nil
#       start_month nil
#     end
#   end
# end
