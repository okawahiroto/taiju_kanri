# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    target_weight 65.5
    password "password"
    password_confirmation "password"

    factory :admin do
      admin true
    end
  end
end
