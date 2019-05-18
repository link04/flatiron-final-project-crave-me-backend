class MatchedCraveSerializer < ActiveModel::Serializer
  attributes :id, :accepted_match, :created_at, :match_id, :crave_id, :user_data
end
