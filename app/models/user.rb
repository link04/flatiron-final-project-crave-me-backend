class User < ApplicationRecord
  has_secure_password
  has_one_attached :image
  belongs_to :gender, optional: true
  has_many :interested_genders

end
