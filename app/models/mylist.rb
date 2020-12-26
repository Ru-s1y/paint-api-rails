class Mylist < ApplicationRecord
  belongs_to :picture
  belongs_to :album

  # picture_idとalbum_idの組み合わせは一意性を持つ
  validates :album_id, uniqueness { scope: :picture_id }
end
