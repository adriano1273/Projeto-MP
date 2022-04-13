# frozen_string_literal: true

class Rating < ApplicationRecord
  belongs_to :user
  validates :user_id, :value, presence: true
  validates :value, numericality: { less_than_or_equal_to: 5 }
end
