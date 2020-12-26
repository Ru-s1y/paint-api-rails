class Album < ApplicationRecord
  
  belongs_to :user, optional: true
  has_many :favorite_albums, dependent: :destroy
  has_many :mylists, dependent: :destroy
  has_many :pictures, through: :mylists

  validates :name, :user_id, presence: true
  validates :publish, :inclusion => { :in => [true, false] }
end
