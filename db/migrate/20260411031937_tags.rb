class Tags < ActiveRecord::Migration[8.1]
  def change
    create_table :tags do |t|
      t.string :tag, index: true
      t.timestamps
    end
  end
end
