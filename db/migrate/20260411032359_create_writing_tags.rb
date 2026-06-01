class CreateWritingTags < ActiveRecord::Migration[8.1]
  def change
    create_table :writing_tags do |t|
      t.belongs_to :writing, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
