class MatchedCrave < ApplicationRecord
  belongs_to :crave , dependent: :destroy
  belongs_to :match , dependent: :destroy
  has_one :user, through: :crave

  def user_data()
    user_copy = self.crave.user
    return {
      id: user_copy.id,
      full_name: user_copy.full_name,
      image_url: user_copy.image_url,
      age: user_copy.age,
      gender: user_copy.gender,
      crave: crave
    }
  end

end
