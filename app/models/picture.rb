class Picture < ApplicationRecord

  belongs_to :user, optional: true
  validates :name, :image, :user_id, presence: true
  validates :publish, :inclusion => { :in => [true, false] }

  # development, test環境用
  # def parse_base64(data, extension)
  #   filename = Time.zone.now.to_s + extension
  #   File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
  #     f.write(data)
  #   end
  # end

  private
    # def attach_image(filename)
    # end

end