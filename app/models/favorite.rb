class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :music

  validates :user_id, :music_id, :value, presence: true
end
