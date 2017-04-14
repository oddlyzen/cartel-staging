# FactoryGirl.define do
#   factory :series do
#
#     title            'Deeply Twisted'
#     description      'This is a series of twisted arts'
#     year             '2016-01-01'
#     link 'https://google.com'
#
#     association :exhibition, factory: :exhibition, strategy: :build
#
#     trait :invalid do
#       title ''
#       link ''
#     end
#
#     trait :invalid_for_publish do
#       description ''
#       year ''
#     end
#
#   end
# end
