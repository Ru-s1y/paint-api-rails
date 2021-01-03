# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User
User.create!(
  name: "レモネード太郎",
  email: "first_test@example.com",
  password: "passwordtest",
  password_confirmation: "passwordtest",
  activated: true,
)

# Users
3.times do |n|
  name = Faker::Games::Pokemon.name
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

# Picture
name = [
  "木",
  "ハート",
  "鉛筆"
]
description = [
  "背景で出てきそうな木。",
  "拾うと回復する。",
  "今となってはほとんど使わなくなった。"
]
image = [
  "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/bbd6615ac7889a3273f8b3008bc9e27ab72e75f9.png",
  "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/c661356b03039ad0ce6c495af8236e40a0553e8f.png",
  "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/096228a856f8805920940af4597078078618eb96.png"
]
3.times do |m|
  # 木、ハート、鉛筆
  Picture.create!(
    name: name[m],
    description: description[m],
    image: image[m],
    publish: true,
    user_id: m + 1,
  )
end

# 100.times do |d|
#   Picture.create!(
#     name: "name#{d}",
#     description: "description#{d}",
#     image: "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/096228a856f8805920940af4597078078618eb96.png",
#     publish: true,
#     user_id: 1,
#   )
# end

# Album
3.times do |i|
  description = Faker::Books::CultureSeries.book
  Album.create!(
    name: "アルバム#{i + 1}",
    description: description,
    publish: true,
    user_id: i + 1,
  )
end

# Mylist
3.times do |x|
  Mylist.create!(
    album_id: x + 1,
    picture_id: x + 1,
  )
end

# Tags
tag_name = [
  "自然",
  "ドロップ品",
  "文房具",
  "赤",
  "緑",
  "青",
]
6.times do |a|
  Tag.create!(
    name: tag_name[a]
  )
end

# 100.times do |b|
#   name = Faker::Game.title
#   Tag.create!(
#     name: name
#   )
# end

# Tag_picture
3.times do |c|
  PictureTag.create!(
    picture_id: c + 1,
    tag_id: c + 1
  )
end

# 3.times do |c|
#   TagAlbum.create!(
#     album_id: c + 1,
#     tag_id: c + 1
#   )
# end