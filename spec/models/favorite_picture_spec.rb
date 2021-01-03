require 'rails_helper'

# create_table "favorite_pictures", force: :cascade do |t|
#   t.bigint "user_id", null: false
#   t.bigint "picture_id", null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["picture_id"], name: "index_favorite_pictures_on_picture_id"
#   t.index ["user_id"], name: "index_favorite_pictures_on_user_id"
# end

RSpec.describe FavoritePicture, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  # バリデーションに失敗する
  # it "正しく入力したとき" do
  #   favorite = FavoritePicture.create!(
  #     user_id: 1,
  #     picture_id: 1,
  #   )
  #   expect(favorite.save).to be_valid
  # end

  it "ユーザーIDがなかった場合、失敗する" do
    favorite = FavoritePicture.new(
      picture_id: '1'
    )
    expect(favorite.save).to be_falsey
  end

  it "ピクチャーIDがなかった場合、失敗する" do
    favorite = FavoritePicture.new(
      user_id: '1'
    )
    expect(favorite.save).to be_falsey
  end
end
