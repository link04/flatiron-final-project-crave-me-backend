class UserSerializer < ActiveModel::Serializer
  attributes  :full_name, :email, :image_url, :coordinates, :date_of_birth, :age
  belongs_to :gender
  has_many :liked_genders
end
