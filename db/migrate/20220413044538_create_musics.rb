class CreateMusics < ActiveRecord::Migration[7.0]
  def change
    create_table :musics do |t|
      t.string :title
      t.text :description
      t.binary :photo

      t.timestamps
    end
  end
end
