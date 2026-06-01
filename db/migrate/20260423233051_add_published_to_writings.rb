class AddPublishedToWritings < ActiveRecord::Migration[8.1]
  def change
    add_column :writings, :published, :boolean, default: false
  end
end
