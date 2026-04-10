class AddOriginallyPublishedToChapters < ActiveRecord::Migration[8.1]
  def change
    add_column :chapters, :originally_published, :datetime
  end
end
