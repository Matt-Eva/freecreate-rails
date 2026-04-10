class Chapter < ApplicationRecord
  belongs_to :writing
  belongs_to :user
  has_rich_text :content
end
