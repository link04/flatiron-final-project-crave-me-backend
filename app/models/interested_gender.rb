class InterestedGender < ApplicationRecord
  belongs_to :user
  belongs_to :gender
end
