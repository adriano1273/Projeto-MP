# frozen_string_literal: true

class Music < ApplicationRecord
  validates :title, :description, presence: true
  def descricao
    "Música: #{title}; Descrição: #{description}"
  end
end
