class AddDefaultUuidToWriting < ActiveRecord::Migration[8.1]
  def change
    change_column_default :writings, :uuid, from: nil, to: -> {"gen_random_uuid()"}
  end
end
