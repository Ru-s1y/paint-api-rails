require 'rails_helper'

RSpec.describe Picture, type: :model do
  name = "testuser"
  description = "test description"
  image = "https://rails-paint-api.s3-ap-northeast-1.amazonaws.com/uploader/1/76f5384266449e657ada7574d671f9d696f4debc.png"

  it "ピクチャーが正しく保存される" do
    picture = Picture.create(
      name: name,
      description: description,
      image: image,
      publish: "true",
      user_id: "1"
    )
    expect(picture).to be_valid
  end

  it "descriptionがない場合でも有効" do
    picture = Picture.create(
      name: name,
      description: "",
      image: image,
      publish: "false",
      user_id: "2"
    )
    expect(picture).to be_valid
  end

  it "nameがない場合、無効になる" do
    picture = Picture.new(
      name: "",
      description: description,
      image: image,
      publish: "false",
      user_id: "1"
    )
    expect(picture.save).to be_falsey
  end

  it "imageがない場合、無効になる" do
    picture = Picture.new(
      name: name,
      description: description,
      image: "",
      publish: "false",
      user_id: "1"
    )
    expect(picture.save).to be_falsey
  end

  it "user_idがない場合、無効になる" do
    picture = Picture.new(
      name: name,
      description: description,
      image: image,
      publish: "true",
      user_id: ""
    )
    expect(picture.save).to be_falsey
  end

  it "publishがない場合、無効になる" do
    picture = Picture.new(
      name: name,
      description: description,
      image: image,
      publish: "",
      user_id: "1"
    )
    expect(picture.save).to be_falsey
  end

  # it "雛形" do
  #   picture = Picture.create(
  #     name: "",
  #     description: "",
  #     image: "",
  #     publish: ""
  #     user_id: ""
  #   )
  #   expect(picture).to be_valid
  #   expect(picture.save).to be_falsey
  # end
end
