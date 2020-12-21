FactoryBot.define do
  factory :picture do
    name { "MyString" }
    description { "MyString" }
    image { "MyString" }
    publish { false }
    user_id { 1 }
  end
end
