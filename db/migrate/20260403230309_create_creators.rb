class CreateCreators < ActiveRecord::Migration[8.1]
  def change
    create_table :creators do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.uuid :uuid, index: true, default: "gen_random_uuid()"

      t.timestamps
    end
  end
end
