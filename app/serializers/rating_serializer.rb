class RatingSerializer < ActiveModel::Serializer
  attributes :value, :user_id, :music_id
end
