class AddIsAdultToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :is_adult, :boolean
  end
end
