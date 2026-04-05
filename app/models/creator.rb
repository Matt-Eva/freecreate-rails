class Creator < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :name, uniqueness: {scope: :user_id, message: "you already have a creator profile with that name."}
  has_rich_text :about
end
