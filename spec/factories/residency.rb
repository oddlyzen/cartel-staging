FactoryGirl.define do
  factory :residency do
    start_month 1
    start_year 1990
    end_month 12
    end_year 1994
    body 'Professional Artist Network'
    country 'Italy'
    state 'Venice'
    current false

    trait :no_duration do
      start_month nil
      start_year nil
      end_month nil
      end_year nil
    end

    trait :no_end_duration do
      end_month nil
      end_year nil
    end

    trait :no_end_duration_and_current do
      end_month nil
      end_year nil
      current true
    end

  end
end
