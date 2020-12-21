FactoryBot.define do
  factory :album do
    name { "MyString" }
    description { "MyString" }
    publish { false }
    user_id { 1 }
  end
end
