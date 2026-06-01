class AddUuidToWritings < ActiveRecord::Migration[8.1]
  def change
    add_column :writings, :uuid, :uuid
    add_index :writings, :uuid
  end
end
