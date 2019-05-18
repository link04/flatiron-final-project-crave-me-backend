class CraveSerializer < ActiveModel::Serializer
  attributes  :id, :created_at, :dessert_id, :other, :user_id, :main_course_id, :drink_id
end
