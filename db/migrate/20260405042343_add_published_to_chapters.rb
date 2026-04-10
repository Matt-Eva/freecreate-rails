class AddPublishedToChapters < ActiveRecord::Migration[8.1]
  def change
    add_column :chapters, :published, :boolean
  end
end
