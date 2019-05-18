class MatchSerializer < ActiveModel::Serializer
  attributes :id, :status, :created_at, :matched_menu_choices
  has_many :matched_craves
end
