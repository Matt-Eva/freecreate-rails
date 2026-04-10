class CreateWritings < ActiveRecord::Migration[8.1]
  def change
    create_table :writings do |t|
      t.belongs_to :creator, null: false, foreign_key: true
      t.string :title
      t.text :tags
      t.belongs_to :user, null: false, foreign_key: true
      t.text :description
      t.bigint :rank, index: true
      t.bigint :rel_rank, index: true
      t.bigint :likes
      t.bigint :donations
      t.bigint :lib_adds
      t.bigint :list_adds
      t.bigint :flags
      t.bigint :views
      t.integer :rank_tracker
      t.datetime :last_published, index: true

      t.timestamps
    end
  end
end
