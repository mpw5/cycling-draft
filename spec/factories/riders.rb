FactoryBot.define do
  factory :rider do
    name { Faker::Name.unique.name }
    team { Faker::Company.unique.name }
    country { Faker::Address.country_code }
    price { Faker::Number.number(digits: 2) }
    previous_score { Faker::Number.number(digits: 4) }
    score { Faker::Number.number(digits: 4) }
  end
end
