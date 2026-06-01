class AddUuidToChapters < ActiveRecord::Migration[8.1]
  def change
    add_column :chapters, :uuid, :uuid
    add_index :chapters, :uuid
  end
end
