FactoryBot.define do
  factory :team do
    league
    name { Faker::Sports::Football.unique.team }
  end
end
