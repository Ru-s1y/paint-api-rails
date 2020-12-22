class FavoritePicture < ApplicationRecord
  belongs_to :user
  belongs_to :picture

  # ピクチャーとユーザーの組み合わせは一意性を持つ
  validates_uniqueness_of :picture_id, scope: :user_id
end
