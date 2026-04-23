class Writing < ApplicationRecord
  validates :title, presence: true
  
  belongs_to :creator
  belongs_to :user
  has_many :chapters, dependent: :destroy
end
