FactoryBot.define do
  factory :league do
    name { Faker::Sports::Football.competition }
  end
end
