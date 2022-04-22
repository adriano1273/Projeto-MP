class AddAverageFieldToMusic < ActiveRecord::Migration[6.1]
  def change
    add_column :musics, :average, :float
  end
end
