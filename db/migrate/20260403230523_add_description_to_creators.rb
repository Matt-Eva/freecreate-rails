class AddDescriptionToCreators < ActiveRecord::Migration[8.1]
  def change
    add_column :creators, :description, :string
  end
end
