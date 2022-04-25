# frozen_string_literal: true

class AddRefToRating < ActiveRecord::Migration[6.1]
  def change
    add_reference :ratings, :music, foreign_key: true
  end
end
