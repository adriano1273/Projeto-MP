class CreateInteresteds < ActiveRecord::Migration[7.0]
  def change
    create_table :interesteds do |t|
      t.references :user, null: false, foreign_key: true
      t.references :music, null: false, foreign_key: true

      t.timestamps
    end
  end
end
