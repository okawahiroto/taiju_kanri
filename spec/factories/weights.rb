# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weight do
    association :user
    date "2014-05-05"
    weight 68.0
  end
end
