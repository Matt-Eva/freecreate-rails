class AddDefaultEmptyStringForChapterTitle < ActiveRecord::Migration[8.1]
  def change
    change_column_default :chapters, :title, from: nil, to: ""
  end
end
