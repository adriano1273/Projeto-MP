class AddRefToMusic < ActiveRecord::Migration[6.1]
  def change
    add_reference :musics, :genre, foreign_key: true
  end
end
