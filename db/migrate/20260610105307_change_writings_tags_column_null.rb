class ChangeWritingsTagsColumnNull < ActiveRecord::Migration[8.1]
  def change
    change_column_null :writings, :tags, false
  end
end
