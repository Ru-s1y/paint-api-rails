class Album < ApplicationRecord
  
  belongs_to :user, optional: true
  has_many :favorite_albums, dependent: :destroy

  has_many :mylists, dependent: :destroy
  has_many :pictures, through: :mylists

  # has_many :tag_albums
  # has_many :tags, through: :tag_albums

  validates :name, :user_id, presence: true
  validates :publish, :inclusion => { :in => [true, false] }
end
