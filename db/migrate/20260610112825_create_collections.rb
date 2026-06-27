class CreateCollections < ActiveRecord::Migration[8.1]
  def change
    create_table :collections do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :creator, null: false, foreign_key: true
      t.string :title
      t.string :tags, array: true, null: false, default: []
      t.string :topics, array: true, null: false, default: []

      t.timestamps
    end
    add_index :collections, [ :topics, :tags ], using: :gin
  end
end
