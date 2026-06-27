class AddNeverPublishedToChapters < ActiveRecord::Migration[8.1]
  def change
    add_column :chapters, :never_published, :boolean, default: true, null: false
  end
end
