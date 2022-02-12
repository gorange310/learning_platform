FactoryBot.define do
  factory :api_access_token do
    association :user, factory: [:user]
    key { SecureRandom.uuid.delete("-") }
  end

  factory :user do
    email { Faker::Internet.email }
    password { "a00000000" }
    password_confirmation { "a00000000" }
  end

  factory :program do
    name { Faker::Educator.course_name }
    association :category, factory: :program_category
    association :currency, factory: :currency
    price { 120 }
    association :type, factory: :program_type
    url { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    validity_period { 20 }
  end

  factory :program_category do
    name { Faker::Educator.subject }
  end

  factory :currency do
    name { Faker::Currency.code }
  end

  factory :program_type do
    name { Faker::Hobby.activity }
  end
end
