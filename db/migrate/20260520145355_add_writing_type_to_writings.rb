class AddWritingTypeToWritings < ActiveRecord::Migration[8.1]
  def change
    add_column :writings, :writing_type, :string, null: false, default: "Short Story" 
    add_column :writings, :genres, :string, array: true, default: []
    change_column :writings, :tags, :string, array: true, default: [], using: "string_to_array(tags, ', ')"
    add_index :writings, :writing_type
    add_index :writings, [:genres, :tags], using: :gin
  end
end
