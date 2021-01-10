require 'rails_helper'

# create_table "users", force: :cascade do |t|
#   t.string "name", default: "NewUser"
#   t.string "email", null: false
#   t.string "password_digest", null: false
#   t.boolean "activated", default: true, null: false
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["email"], name: "index_users_on_email", unique: true
# end

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "メールアドレス、パスワード、確認用パスワードがある場合、有効である" do
    user = User.new(
      email: "test_user@example.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(user).to be_valid
  end

  it "何も入力がない場合、無効になる" do
    user = User.new
    expect(user.save).to be_falsey
  end

  it "メールアドレスがない場合、無効である" do
    user = User.new(
      email: "",
      password: "password",
      password_confirmation: "password"
    )
    expect(user.save).to be_falsey
  end

  it "メールアドレスが重複していた場合、無効である" do
    user = User.new(
      email: "test_user@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user.save
    user2 = User.new(
      email: "test_user@example.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(user2.save).to be_falsey
  end

  it "パスワードがない場合、無効である" do
    user = User.new(
      email: "test_user@example.com",
      password: "",
      password_confirmation: ""
    )
    expect(user.save).to be_falsey
  end

  it "パスワードのみがない場合、無効である" do
    user = User.new(
      email: "test_user@example.com",
      password: "password",
      password_confirmation: ""
    )
    expect(user.save).to be_falsey
  end

  it "確認用パスワードのみがない場合、無効である" do
    user = User.new(
      email: "test_user@example.com",
      password: "",
      password_confirmation: "password"
    )
    expect(user.save).to be_falsey
  end

  it "メールアドレスが重複している時、無効である。" do
    User.create(
      name: "testUser",
      email: "test_user@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user = User.new(
      name: "testUser2",
      email: "test_user@example.com",
      password: "password",
      password_confirmation: "password"
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
end
