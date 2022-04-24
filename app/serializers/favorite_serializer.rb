class FavoriteSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :music_id, :value

  belongs_to :music
end
