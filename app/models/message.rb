class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

    def user_data()
      user_copy = self.user
      return {
        id: user_copy.id,
        full_name: user_copy.full_name,
        image_url: user_copy.image_url,
        age: user_copy.age,
        gender: user_copy.gender.name
      }
    end

end
