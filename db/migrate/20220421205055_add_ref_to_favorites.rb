# frozen_string_literal: true

class AddRefToFavorites < ActiveRecord::Migration[6.1]
  def change
    add_reference :favorites, :music, null: false, foreign_key: true
  end
end
