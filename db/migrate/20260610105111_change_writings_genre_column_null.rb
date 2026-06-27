class ChangeWritingsGenreColumnNull < ActiveRecord::Migration[8.1]
  def change
    change_column_null :writings, :genres, false
  end
end
