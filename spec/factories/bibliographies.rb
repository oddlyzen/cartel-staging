FactoryBot.define do
  factory :bibliography do
    title 'Bib title'
    publication_title 'Publication title'
    publisher 'publisher'
    edition 'edition'
    author 'author'
    page_number 'pg. 20'
    month 1
    year 1990

    trait :with_attachment do
      attachment_url 'http://cdn.pan.com/attachment'
    end

    trait :with_pdf do
      pdf_url 'http://cdn.pan.com/pdf'
    end
  end
end
