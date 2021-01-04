require 'rails_helper'

# create_table "albums", force: :cascade do |t|
#   t.string "name", default: "NewAlbum", null: false
#   t.string "description"
#   t.boolean "publish", default: false
#   t.integer "user_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
# end

RSpec.describe Album, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  name = "sampleAlbum"
  description = "sample"

  it "属性を入れたとき保存される" do
    album = Album.create!(
      name: name,
      description: description,
      publish: "true",
      user_id: 1,
    )
    expect(album).to be_valid
  end

  it "公開設定をしなかったときfalseになる" do
    album = Album.create!(
      name: name,
      description: description,
      user_id: 1,
    )
    expect(album).to be_valid
    expect(album.publish).to eq(false)
  end

  it "ユーザーIDがないと失敗する" do
    album = Album.new(
      name: name,
      description: description,
      publish: "false",
    )
    expect(album.save).to be_falsey
  end
end
