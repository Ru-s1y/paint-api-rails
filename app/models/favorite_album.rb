class FavoriteAlbum < ApplicationRecord
  belongs_to :user
  belongs_to :album

  # アルバムとユーザーの組み合わせは一意性を持つ
  validates_uniqueness_of :album_id, scope: :user_id
end
