FactoryBot.define do
  factory :league do
    user
    name { Faker::Company.unique.name }
  end
end
