class AddUniqueIndexUserIdCreatorNameToCreators < ActiveRecord::Migration[8.1]
  def change
    add_index :creators, [:user_id, :name], unique: true
  end
end
