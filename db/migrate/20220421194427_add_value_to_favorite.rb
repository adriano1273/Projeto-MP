class AddValueToFavorite < ActiveRecord::Migration[6.1]
  def change
    add_column :favorites, :value, :int
  end
end
