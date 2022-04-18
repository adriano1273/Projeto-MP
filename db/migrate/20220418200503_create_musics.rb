# frozen_string_literal: true

class CreateMusics < ActiveRecord::Migration[6.1]
  def change
    create_table :musics do |t|
      t.string :title
      t.text :description
      t.binary :photo

      t.timestamps
    end
  end
end
