FactoryBot.define do
 factory :user do
  name { "テスト太郎" }
  sequence(:email) { |n| "test#{n}@gmail.com" }
  password { "password" }
 end
end