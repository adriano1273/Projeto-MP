# frozen_string_literal: true

class Music < ApplicationRecord
  validates :title, :description, presence: true
  has_many :ratings, dependent: :destroy
  def descricao
    "Música: #{title}; Descrição: #{description}"
  end
end
