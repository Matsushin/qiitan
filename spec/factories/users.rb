FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    email { Faker::Internet.email }
    password { 'password' }
  end
end
