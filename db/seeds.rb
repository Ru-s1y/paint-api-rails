# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name: "レモネード太郎",
  email: "testfirst@example.com",
  password: "passwordtest",
  password_confirmation: "passwordtest",
  activated: true,
)

3.times do |n|
  name = Faker::Games::Zelda.character
  email = Faker::Internet.email
  password = "pass#{n}wordess"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
  )
end

3.times do |m|
  name = [
    "木",
    "ハート",
    "鉛筆"
  ]
  description = [
    "ゲームの背景で出てきそうな木。",
    "拾うと回復する。",
    "今となってはほとんど使わなくなった。"
  ]
  image = [
    "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/bbd6615ac7889a3273f8b3008bc9e27ab72e75f9.png",
    "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/c661356b03039ad0ce6c495af8236e40a0553e8f.png",
    "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/096228a856f8805920940af4597078078618eb96.png"
  ]
  # 木、ハート、鉛筆
  Picture.create!(
    name: name[m],
    description: description[m],
    image: image[m],
    publish: true,
    user_id: m + 1,
    album_id: m + 1
  )
end



3.times do |i|
  name = Faker::Creature::Animal.name
  description = Faker::Books::CultureSeries.book
  Album.create!(
    name: name,
    description: description,
    publish: true,
    user_id: i + 1,
  )
end