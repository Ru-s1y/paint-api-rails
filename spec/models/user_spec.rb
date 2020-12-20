require 'rails_helper'

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
end
