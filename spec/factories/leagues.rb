FactoryBot.define do
  factory :league do
    name { Faker::Sports::Football.unique.competition }
  end
end
