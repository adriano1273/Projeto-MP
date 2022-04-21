class RemoveRefFromFavorite < ActiveRecord::Migration[6.1]
  def change
    remove_reference :favorites, :music, null: false, foreign_key: true
  end
end
