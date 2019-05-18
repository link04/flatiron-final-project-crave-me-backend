class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :created_at
  belongs_to :match
  has_many :messages
  has_many :users
end
