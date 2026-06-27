class Writing < ApplicationRecord
  validates :title, presence: true
  validates :writing_type, presence: true
  validates :last_published, presence: true
  # validates :topics, length: { maximum: 3 }
  validates :tags, length: { maximum: 20 } 

  belongs_to :creator
  belongs_to :user
  has_many :chapters, dependent: :destroy

  FICTION_GENRES = ["No Topic", "Action", "Adventure", "Comedy", "Drama", "Erotica", "Fantasy", "Historical Fiction", "Horror", "Literary Fiction", "Magical Realism", "Mystery", "Romance", "Science Fiction", "Slice of Life", "Speculative Fiction", "Social Fiction", "Supernatural", "Superhero", "Thriller", "Young Adult"].freeze
  ESSAY_TOPICS = [].freeze
  WRITING_TYPES = ["Short Story", "Novelette", "Novella", "Novel", "Poetry", "Essay", "Thought Piece", "Blog", "Memoir"].freeze
end
