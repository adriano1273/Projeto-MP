class Rating < ApplicationRecord
  validates :user_id, :music_id, :value, presence: true
  validates :value, numericality: { less_than_or_equal_to: 5 }
end
