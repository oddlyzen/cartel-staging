FactoryBot.define do
  factory :education do
    association :user

    institution 'NUS'
    start_month 1
    start_year 1990
    end_month 10
    end_year 1995
    name 'Biology'
    state 'Singapore'
    country 'Singapore'
    done false
  end

end
