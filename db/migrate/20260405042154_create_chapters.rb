class CreateChapters < ActiveRecord::Migration[8.1]
  def change
    create_table :chapters do |t|
      t.belongs_to :writing, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title
      t.integer :number

      t.timestamps
    end
  end
end
