class Album < ApplicationRecord
  
  has_many :pictures
  belongs_to :user, optional: true
  has_many :favorite_albums, dependent: :destroy

  validates :name, :user_id, presence: true
  validates :publish, :inclusion => { :in => [true, false] }
end
