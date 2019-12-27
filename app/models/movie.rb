class Movie < ApplicationRecord

  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  has_many :reviews, dependent: :destroy

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :title, :released_on, :duration, presence: true

  validates :description, length: { minimum: 25 }

  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

  validates :image_file_name, format: {
      with: /\w+\.(jpg|png)\z/i,
      message: "must be a JPG or PNG image"
  }

  validates :rating, inclusion: { in: RATINGS }

  scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on desc") }
  scope :recent, ->(max=5) { released.limit(max) }


  def flop?
    total_gross < 225000000
  end

  #def self.released
  #  where("released_on < ?", Time.now).order("released_on desc")
  #end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (self.average_stars / 5.0) * 100
  end

end
