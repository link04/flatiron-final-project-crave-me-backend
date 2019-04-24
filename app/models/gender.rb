class Gender < ApplicationRecord
  has_many :users
  has_many :interested_genders
end
