require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "名前があれば成功" do
    tag = Tag.create!(name: "黄")
    expect(tag).to be_valid
  end

  it "名前がないと失敗する" do
    tag = Tag.new(name: "")
    expect(tag.save).to be_falsey
  end
end
