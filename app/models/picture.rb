class Picture < ApplicationRecord

  belongs_to :user, optional: true
  validates :name, :image, :publish, :user_id, presence: true

end
