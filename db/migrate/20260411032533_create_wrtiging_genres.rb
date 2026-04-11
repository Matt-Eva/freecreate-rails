class CreateWrtigingGenres < ActiveRecord::Migration[8.1]
  def change
    create_table :wrtiging_genres do |t|
      t.belongs_to :writing, null: false, foreign_key: true
      t.belongs_to :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
