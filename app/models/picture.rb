class Picture < ApplicationRecord

  belongs_to :user, optional: true
  has_many :favorite_pictures, dependent: :destroy

  has_many :mylists, dependent: :destroy
  has_many :albums, through: :mylists

  # has_many :tag_pictures
  # has_many :tags, through: :tag_pictures

  validates :name, :image, :user_id, presence: true
  validates :publish, :inclusion => { :in => [true, false] }

end
