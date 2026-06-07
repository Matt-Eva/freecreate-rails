class AddNeverPublishedToWriting < ActiveRecord::Migration[8.1]
  def change
    add_column :writings, :never_published, :boolean
  end
end
