class UpdateChapterDefaults < ActiveRecord::Migration[8.1]
  def change
    change_column_default :chapters, :published, from: nil, to: false
    change_column_null :chapters, :published, false
    change_column_null :chapters, :title, false
    change_column_null :chapters, :originally_published, false
    change_column_default :chapters, :number, from: nil, to: 0
    change_column_null :chapters, :number, false

  end
end
