class Album < ApplicationRecord
  has_many :pictures
  belongs_to :user, optional: true

  validates :name, :user_id, presence: true
  validates :publish, :inclusion => { :in => [true, false] }
end
