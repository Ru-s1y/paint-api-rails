FactoryBot.define do
  factory :picture do
    name { "TestPicture" }
    description { "test picture" }
    image { "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/76f5384266449e657ada7574d671f9d696f4debc.png" }
    publish { false }
    user_id { 1 }
  end
end
