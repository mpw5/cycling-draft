FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
  end
end
