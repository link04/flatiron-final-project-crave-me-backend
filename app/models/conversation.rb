class Conversation < ApplicationRecord
  belongs_to :match
  has_many :messages, dependent: :destroy
  has_many :users, through: :match
end
