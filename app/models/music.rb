# frozen_string_literal: true

class Music < ApplicationRecord
  validates :title, :description, presence: true
  has_many :ratings, dependent: :destroy
  has_one_attached :photo
  def descricao
    "Música: #{title}; Descrição: #{description}"
  end
end
