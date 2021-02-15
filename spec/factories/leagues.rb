FactoryBot.define do
  factory :league do
    name { Faker::Company.unique.name }
  end
end
