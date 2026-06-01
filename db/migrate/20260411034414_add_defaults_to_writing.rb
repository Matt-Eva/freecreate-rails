class AddDefaultsToWriting < ActiveRecord::Migration[8.1]
  def change
    change_column_default :writings, :donations, from: nil, to: 0
    change_column_default :writings, :flags, from: nil, to: 0
    change_column_default :writings, :likes, from: nil, to: 0
    change_column_default :writings, :list_adds, from: nil, to: 0
    change_column_default :writings, :lib_adds, from: nil, to: 0
    change_column_default :writings, :rank, from: nil, to: 0
    change_column_default :writings, :rel_rank, from: nil, to: 0
    change_column_default :writings, :rank_tracker, from: nil, to: 0
    change_column_default :writings, :views, from: nil, to: 1
  end
end
