class ChangeWritingGenreColumnName < ActiveRecord::Migration[8.1]
  def change
    rename_column :writings, :genres, :topics
  end
end
