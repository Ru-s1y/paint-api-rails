FactoryBot.define do
  factory :user do
    name { "newuser" }
    email { "test@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
