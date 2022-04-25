# frozen_string_literal: true

class RatingSerializer < ActiveModel::Serializer
  attributes :value, :user_id, :music_id, :id
end
