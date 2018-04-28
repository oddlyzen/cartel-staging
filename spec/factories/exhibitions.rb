FactoryBot.define do
  factory :exhibition do
    association :venue, factory: :company
    title 'Mega Exhibition'
    category 'in_solo'
    state 'Venice'
    country 'Italy'
    start_year Date.current.year

    trait :with_title do
      title 'Sunset'
    end

    trait :with_attachment do
      pdf_url 'http://cdn.artwork/file.pdf'
    end

    trait :invalid do
      title nil
      pdf_url nil
    end

    trait :with_full_duration do
      start_month 1
      start_year 1990
      end_month 12
      end_year 1994
    end
  end
end
