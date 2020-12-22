# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
3.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true
  )
end

3.times do |m|
  name = Faker::Books::Lovecraft.deity
  description = Faker::Books::Lovecraft.fhtagn
  image = [
    "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/76f5384266449e657ada7574d671f9d696f4debc.png",
    "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/61fc4aeca99d31d9b975e6ed42fc193fc049ad57.png",
    "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/6011ce75d6f22946e6f807f57e12d1ad61160a5a.png"
  ]
  Picture.create!(
    name: name,
    description: description,
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