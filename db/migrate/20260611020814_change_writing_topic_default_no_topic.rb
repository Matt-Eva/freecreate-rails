class ChangeWritingTopicDefaultNoTopic < ActiveRecord::Migration[8.1]
  def change
    change_column_default :writings, :topics, from: [], to: ["No Topic"]
  end
end
