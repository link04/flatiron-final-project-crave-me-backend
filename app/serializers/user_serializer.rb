class UserSerializer < ActiveModel::Serializer
  attributes  :id, :full_name, :email, :image_url, :coordinates, :date_of_birth, :age, :last_crave,
  :active_matches
  belongs_to :gender
  has_many :liked_genders
  has_many :craves

end
