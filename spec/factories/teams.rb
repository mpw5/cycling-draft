FactoryBot.define do
  factory :team do
    user
    league
    name { Faker::Sports::Football.unique.team }
  end
end
