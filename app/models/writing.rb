class Writing < ApplicationRecord
  validates :title, presence: true
  validates :writing_type, presence: true
  validates :las_published, presence: true

  belongs_to :creator
  belongs_to :user
  has_many :chapters, dependent: :destroy

  FICTION_GENRES = ["No Genre", "Action", "Adventure", "Comedy", "Drama", "Erotica", "Fantasy", "Historical Fiction", "Horror", "Literary Fiction", "Magical Realism", "Mystery", "Romance", "Science Fiction", "Slice of Life", "Speculative Fiction", "Social Fiction", "Supernatural", "Superhero", "Thriller", "Young Adult"].freeze
  ESSAY_TOPICS = [].freeze
  WRITING_TYPES = ["Short Story", "Novellete", "Novella", "Novel", "Poetry", "Essay", "Thought Piece", "Blog", "Memoir"].freeze
end
