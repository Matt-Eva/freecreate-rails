class Writing < ApplicationRecord
  belongs_to :creator
  belongs_to :user
  has_many :chapters, dependent: :destroy
end
